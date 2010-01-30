class User < ActiveRecord::Base
  
  has_many :votes
  has_many :downvotes
  has_many :upvotes
  
  # Overriding authlogic validations
  acts_as_authentic do |auth|
    auth.require_password_confirmation = false
  end
  
end
