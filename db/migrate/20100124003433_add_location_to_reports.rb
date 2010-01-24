class AddLocationToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :location, :string   # remote services such as twitter sometimes have a location for the user/status
  end

  def self.down
    remove_column :reports, :location
  end
end
