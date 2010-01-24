=begin
  create_table "reports", :force => true do |t|
    t.string   "yql_id"
    t.string   "provenance"
    t.string   "content"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "votes",                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user"
    t.string   "user_profile_image_url"
    t.string   "user_provenance_key"
    t.string   "user_homepage_url"
  end
=end

class Report < ActiveRecord::Base

  attr_accessor :formatted_output

  simple_search :fields => [:content, :user]

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
    max = calculate(:max, :created_at)
    return if max && Time.now - max < 20.seconds

    stopwords = %w(RT rt crisiscamppdx haiti_tweets).map {|word| "-#{word}"}.join(' ')

    refresh("query.yahooapis.com", "/v1/public/yql",
      {
        "q"  => "select * from twitter.search where q='haiti #{stopwords}';",
        "format" => "xml",
        "env" => "store://datatables.org/alltableswithkeys"
      })

    refresh("query.yahooapis.com", "/v1/public/yql",
      {
        "q"  => "select * from twitter.search where q='#{stopwords}' and geocode='18.542980,-72.343102,50mi';",
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

      # Remove retweets since obstensibly we already have the original tweet
      next if report.content =~ /via @/i

      if (geo = result.at("geo"))
        begin
          report.latitude, report.longitude = (geo/:coordinates).map { |c| c.inner_text.to_f }
        rescue
          #FIXME: deal with a parsing failure here
        end
      end
      if (loc = result.at("location"))
        report.location = loc.inner_text
      end

      report.provenance = "twitter"
      report.user_profile_image_url = result.at("profile_image_url").inner_text
      report.user = result.at("from_user").inner_text

      # TODO this is a bad idea to hardcode - the next crisis will not need this
      # skip aggregators for now!
      next if report.user == "haiti_tweets"
      next if report.user == "haititweets"
      next if report.user == "haititweaks"

      # Prevent duplicate messages
      next if Report.exists?(:content => report.content)


      report.save
    end
    count
  end
end
