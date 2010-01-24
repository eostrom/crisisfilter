ActiveRecord::Schema.define(:version => 0) do
  
  create_table :mocks, :force => true do |t|
    t.column :mock_string, :string
    t.column :mock_text, :text
    t.column :position, :integer
  end

  create_table :foos, :force => true do |t|
  end

end