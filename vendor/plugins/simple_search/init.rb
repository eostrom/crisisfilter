# Include hook code here
require 'simple_search'
ActiveRecord::Base.send(:include, SimpleSearch)