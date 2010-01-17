class Report < ActiveRecord::Base
  named_scope :the_latest, :order => 'created_at DESC', :limit => 1

  def self.refresh_if_needed
    # If tweets slow down but use of our app doesn't, this will
    # result in a lot of extra hits to the Twitter feed.
    return if Time.now - the_latest.first.created_at < 20.seconds

    refresh("query.yahooapis.com", "/v1/public/yql",
      {
        "q"  => "select * from twitter.search where q='#haiti #need -RT -rt';",
        "format" => "xml",
        "env" => "store://datatables.org/alltableswithkeys"
      })
  end

protected

  def self.refresh( host, path, params )
    query_string = params.map do |k,v|
      "#{k}=#{CGI::escape( v )}"
    end.join("&")

    http = Net::HTTP.new( host )

    headers, body = http.get( "#{path}?#{query_string}" )
    if ( headers.code == "200" )
      parse_requests( body )
    else
      RAILS_DEFAULT_LOGGER.error "Unable to fetch request #{headers.code} / #{headers.message}"
    end
  end

  def self.parse_requests( xml_text )
    doc = Hpricot.parse( xml_text )
    (doc/:query/:results).each_with_index do |result, count|
      report = Report.new()

      report.content = result.at("text").inner_text
      report.provenance = "twitter"
      report.yql_id = result.at("id").inner_text
      report.save
    end
    count
  end
end
