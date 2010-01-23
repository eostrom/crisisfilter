class AddUpDownViewsToReport < ActiveRecord::Migration
  def self.up
    add_column :reports, :views, :integer
    rename_column :reports, :votes, :upvotes
    add_column :reports, :downvotes, :integer, :default => 0
  end

  def self.down
    remove_column :reports, :downvotes
    rename_column :upvotes, :votes
    remove_column :reports, :views
  end
end
