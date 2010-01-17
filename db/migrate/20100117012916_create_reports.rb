class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.string :note_record_id
      t.string :entry_date
      t.string :author_name
      t.string :author_email
      t.string :author_phone
      t.date :source_date
      t.boolean :found
      t.string :email_of_found
      t.string :phone_of_found
      t.string :last_known_location
      t.string :text

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
