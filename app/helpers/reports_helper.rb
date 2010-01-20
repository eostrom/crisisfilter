require "net/http"
require "cgi"
require "rubygems"
require "hpricot"

module ReportsHelper

  def select_timeframe(form)
    form.select :timeframe, [
      [ 'the last hour', 'hour' ],
      [ 'today', 'day_0' ],
      [ 'yesterday', 'day_1' ],
      [ 'this week', 'week_0' ],
      [ 'last week', 'week_1' ]
    ]
  end

  def format_status_message(content)
    content.split(' ').collect { |term|
      case term[0..0]
      when '#'
          "<a href='http://search.twitter.com/search?q=%23#{term[1..-1]}'>#{term}</a>"
      when "@"
         "<a href='http://twitter.com/#{term[1..-1]}'>#{term}</a>"
      when "h" || "H"
         if term[0..6].downcase == "http://" # inelegant!! TODO use regex
           "<a href='#{term}'>#{term}</a>"
         else
           term
         end
      else term
      end
    }.join(' ')
  end

end
