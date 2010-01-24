# SimpleSearch
module SimpleSearch
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def simple_search(options = {})      
      write_inheritable_attribute(:simple_search_options, {
                                  :fields => (options[:fields] || []) 
                                  })
      class_inheritable_reader :simple_search_options
      send :extend, SimpleSearch::SingletonMethods
    end
  end

  module SingletonMethods
    # New search method. Its not a simple SQL statement since we want to sanitize the statement before processing.  
    def simple_search_query(query = "", options = {})
      return if simple_search_options[:fields].empty? or query.blank?
      sql = "SELECT * FROM  #{self.table_name} "
      sql_arg = []
      arg_arr = []

      simple_search_options[:fields].each do |field|
        sql_arg << "(#{field.to_s} LIKE ?)"
        arg_arr.push("%#{query}%")
      end

      # add where unless sql_arg is empty
      sql << "WHERE " unless sql_arg.empty?

      # make the sql arg array into a string
      sql << sql_arg.join(' OR ')

      # add in order by
      unless options[:order].blank?
        sql << " ORDER BY #{options[:order]} "
      end

      # create argument array using the sql string and the argument array of values
      arg_arr = [sql] + arg_arr

      # sanitize the sql
      sanitized_sql = self.sanitize_conditions(arg_arr)

      # get results using the argument array
      collection = self.find_by_sql(sanitized_sql)

      return collection
    end
  end  
end
