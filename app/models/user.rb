class User < ActiveRecord::Base
  
  has_many :votes
  has_many :downvotes
  has_many :upvotes
  
  has_many :reports, :through => :votes
  has_many :upvoted_reports,   :through => :upvotes,   :source => :report
  has_many :downvoted_reports, :through => :downvotes, :source => :report
  
  # Overriding authlogic validations
  acts_as_authentic do |auth|
    auth.require_password_confirmation = false
  end
  
end
