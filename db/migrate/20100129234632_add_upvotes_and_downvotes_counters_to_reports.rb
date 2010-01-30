class AddUpvotesAndDownvotesCountersToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :upvotes_counter, :integer
    add_column :reports, :downvotes_counter, :integer
  end

  def self.down
    remove_column :reports, :upvotes_counter
    remove_column :reports, :downvotes_counter
  end
end
