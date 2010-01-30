class RemoveVotesFromReports < ActiveRecord::Migration
  def self.up
    remove_column :reports, :votes
  end

  def self.down
    add_column :reports, :votes, :integer
  end
end
