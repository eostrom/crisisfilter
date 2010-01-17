class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :yql_id
      t.string :provenance
      t.string :content
      t.float :latitude
      t.float :longitude
      t.integer :votes
      t.timestamps

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
