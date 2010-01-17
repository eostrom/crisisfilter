# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_haitistream_session',
  :secret      => '98c84e71a6869a4189f96026610b2405b66156473185d39883f69dc68b0b30b20635a3f08d5dd15e6e12fba2a461d6e44ccd670076745d38cf4e1d35d179221a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
