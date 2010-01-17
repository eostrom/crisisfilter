class SetDefaultVotes < ActiveRecord::Migration
  def self.up
    change_column :reports, :votes, :integer, :default => 0
    Report.update_all('votes = 0', 'votes IS NULL')
  end

  def self.down
    change_column :reports, :votes, :integer
  end
end
