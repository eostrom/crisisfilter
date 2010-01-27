class User < ActiveRecord::Base
  
  # Overriding authlogic validations
  acts_as_authentic do |auth|
    auth.require_password_confirmation = false
  end
  
end
