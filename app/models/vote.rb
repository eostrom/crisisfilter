class Vote < ActiveRecord::Base
  
  has_one :user
  has_one :report
  
  validates_presence_of :user, :report
  validates_uniqueness_of :user_id, :scope => [:report_id], :message => "has already voted on this report."
  
end
