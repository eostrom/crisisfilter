class AddUserFeaturesToReports < ActiveRecord::Migration
  def self.up
    add_column :reports, :user_profile_image_url, :string   # remote services such as twitter have a depiction for a user
    add_column :reports, :user_provenance_key, :string      # remote services such as twitter have a key per user 
    add_column :reports, :user_homepage_url, :string        # remote services such as twitter often have a more info link
  end

  def self.down
    remove_column :reports, :user_profile_image_url
    remove_column :reports, :user_provenance_key
    remove_column :reports, :user_homepage_url
  end
end
