class Vote < ActiveRecord::Base
  
  belongs_to :user
  
  validates_presence_of :user, :report
  validates_uniqueness_of :user_id, :scope => [:report_id], :message => "has already voted on this report."
  
end
