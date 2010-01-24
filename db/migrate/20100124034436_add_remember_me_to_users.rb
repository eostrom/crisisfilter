class AddRememberMeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :remember_token_expires_at, :datetime
    add_column :users, :remember_token, :string
  end

  def self.down
    add_column :users, :remember_token_expires_at
    add_column :users, :remember_token
  end
end
