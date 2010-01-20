class Report < ActiveRecord::Base

  attr_accessor :formatted_output

  named_scope :the_latest, :order => 'created_at DESC', :limit => 1

  named_scope :timeframe, lambda { |timeframe|
    unit, count = timeframe.split('_')
    unit_in_seconds = 1.send(unit)

    if count
      # FIXME: broken for hour
      start_time = (Time.now.send("beginning_of_#{unit}") -
        count.to_i * unit_in_seconds)
      end_time = start_time + unit_in_seconds
    else
      start_time = Time.now - unit_in_seconds
      end_time = Time.now
    end

    { :conditions => ['created_at BETWEEN ? AND ?', start_time, end_time] }
  }

  def self.refresh_if_needed
    # If tweets slow down but use of our app doesn't, this will
    # result in a lot of extra hits to the Twitter feed.
    return if Time.now - calculate(:max, :created_at) < 20.seconds

    stopwords = %w(RT rt crisiscamppdx haiti_tweets).map {|word| "-#{word}"}.join(' ')

    refresh("query.yahooapis.com", "/v1/public/yql",
      {
        "q"  => "select * from twitter.search where q='#haiti #need #{stopwords}';",
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

      report.yql_id = result.at("id").inner_text
      next if exists?(:yql_id => report.yql_id)

      report.content = result.at("text").inner_text
      next if report.content =~ /via @/i

      report.provenance = "twitter"
      report.user_profile_image_url = result.at("profile_image_url").inner_text
      report.user = result.at("from_user").inner_text

      # TODO this is a bad idea to hardcode - the next crisis will not need this
      # skip aggregators for now!
      next if report.user == "haiti_tweets"
      next if report.user == "haititweets"
      next if report.user == "haititweaks"

      report.save
    end
    count
  end
end
