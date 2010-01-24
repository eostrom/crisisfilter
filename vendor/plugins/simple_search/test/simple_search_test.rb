require File.dirname(__FILE__) + '/test_helper.rb' 

class SimpleSearchTest < ActiveSupport::TestCase
  load_schema
  
  self.fixture_path = plugin_dir + '/fixtures'  
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  self.pre_loaded_fixtures = true
  fixtures :all
  
  # Our Mock class that we use to test the simple search on
  class Mock < ActiveRecord::Base
    simple_search :fields => [:mock_string, :mock_text]
  end
  
  # Another class we use to make sure that the methods are not extended
  # 
  class Foo < ActiveRecord::Base
  end
  
  test "has a Mock class initialized" do
    assert_nothing_raised("NameError"){ Mock.new }
  end
  
  test "has a Foo class initialized" do
    assert_nothing_raised("NameError"){ Foo.new }
  end
  
  test "should have several mocks in place" do
    assert(!Mock.all.empty?)
  end
  
  test "Mock should respond to simple_search method" do
    assert_respond_to(Mock, :simple_search)
  end
  
  test "Foo should respond to simple_search method" do
    assert_respond_to(Foo, :simple_search)
  end
  
  test "Mock should respond to simple_search_query method" do
    assert_respond_to(Mock, :simple_search_query)
  end
  
  # Foo hasn't called the simple_search method so the simple_search query
  # shouldn't be available.
  test "Foo should not respond to simple_search_query method" do
    assert(!Foo.respond_to?(:simple_search_query))
  end
  
  test "should find several Mocks by querying 'something'" do
    mocks = Mock.simple_search_query("something")
    assert(!mocks.empty?)
  end
  
  test "should not find any Mocks by querying 'foobar'" do
    mocks = Mock.simple_search_query("foobar")
    assert(mocks.empty?)
  end
  
  test "should find one Mock by querying 'apple'" do
    mocks = Mock.simple_search_query("apple")
    assert_equal(mocks.size, 1)    
  end
  
  test "should order mocks based on position" do
    mocks = Mock.simple_search_query("something", :order => "position DESC")
    assert_equal(mocks.first.position, 5)
  end
  
end