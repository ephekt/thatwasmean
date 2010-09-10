# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_that_was_mean_session',
  :secret      => '80b2b3983e379a8b925931d42b79a3969e7ee9ec16866847829519596cbbbaaba28c099760e679f954066dac66b59a8afcdf0bd7ca343f7d19af2cf4a5b7f9d2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
