require 'webmock'
include WebMock

Before do
  WebMock.disable_net_connect!
  WebMock.reset_webmock
end
