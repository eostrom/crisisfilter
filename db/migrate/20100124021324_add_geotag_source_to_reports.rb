class AddGeotagSourceToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :geotag_source, :string
  end

  def self.down
    remove_column :reports, :geotag_source
  end
end
