class AddUserToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :user, :string
  end

  def self.down
    remove_column :reports, :user
  end
end
