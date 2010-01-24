Given /^these tweets exist:$/ do |reports|
  defaults = {}

  stub_request(:get, %r{query.yahooapis.com/.*/alltableswithkeys.*}).to_return(
    :body => Nokogiri::XML::Builder.new do |xml|
      xml.root {
        xml.query {
          reports.hashes.each_with_index do |hash, index|
            xml.results {
              xml.id_ hash['id'] || "yql_#{index}"
              xml.from_user hash['from_user'] || 'a_user'
              xml.text_ hash['text'] || 'A message'
              xml.profile_image_url(hash['profile_image_url'] ||
                'http://profile_image_url.com/')
            }
          end
        }
      }
    end.to_xml)
end

Then /^I should see( only)? these tweets:$/ do |only, reports|
  # TODO: this is quite brittle, depending on the order in which
  # our view presents the info
  table = tableish('.update', '.username, .content')
  header = ['user', 'content']

  reports.hashes.each do |report|
    report['user'] = "@#{report['user']}" if /^[^@]/ =~ report['user']
    assert(
      table.any? do |row|
        report.all? do |key, value|
          index = header.index(key)
          assert(index, "No #{key} header found")
          index && (row[index] == value)
        end
      end,
      "Couldn't find: #{report.inspect}")
  end
end
