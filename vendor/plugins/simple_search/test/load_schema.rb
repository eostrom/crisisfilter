ENV['RAILS_ENV'] = 'test' 
ENV['RAILS_ROOT'] ||=  plugin_dir + '/../../../..' 
require File.expand_path(File.join(ENV['RAILS_ROOT'], 'config/environment.rb')) 

def load_schema 
  config = YAML::load(IO.read(plugin_dir + '/database.yml'))  
  ActiveRecord::Base.logger = Logger.new(plugin_dir + "/debug.log")  
  db_adapter = ENV['DB'] 
  # no db passed, try one of these fine config-free DBs before bombing.  
  db_adapter ||= begin 
    require 'rubygems'  
    require 'sqlite'  
    'sqlite'  
    rescue MissingSourceFile
      begin 
        require 'sqlite3'  
        'sqlite3'  
        rescue MissingSourceFile 
      end  
    end  
  if db_adapter.nil? 
    raise "No DB Adapter selected. Pass the DB= option to pick one, or install Sqlite or Sqlite3."  
  end  
  ActiveRecord::Base.establish_connection(config[db_adapter])  
  load(plugin_dir + "/schema.rb")  
  require plugin_dir + '/../init.rb' 
end
