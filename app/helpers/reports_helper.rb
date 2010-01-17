require "net/http"
require "cgi"
require "rubygems"
require "hpricot"

module ReportsHelper
  # TODO: these don't really belong in a helper

  def self.parse_requests( xml_text )
    doc = Hpricot.parse( xml_text )
    (doc/:query/:results).each do |result|
      report = Report.new()

      report.content = result.at("text").inner_text
      report.provenance = "twitter"
      report.yql_id = result.at("id").inner_text
      report.save
    end
  end

  def self.get_update( host, path, params )
    query_string = params.map do |k,v|
      "#{k}=#{CGI::escape( v )}"
    end.join("&")

    http = Net::HTTP.new( host )

    puts "#{path}?#{query_string}"

    headers, body = http.get( "#{path}?#{query_string}" )
    if ( headers.code == "200" )
      parse_requests( body )
    else
      puts "Unable to fetch request #{headers.code} / #{headers.message}"
    end
  end
end
