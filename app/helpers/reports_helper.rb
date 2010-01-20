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
end
