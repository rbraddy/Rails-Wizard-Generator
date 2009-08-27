# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_app_session',
  :secret      => 'd447191fe7024785d7fb52218b9fc9c794d5ff33c6da973822dfd1b97b232c08fd3b00b6d09cead0f8b16026eed0ee60754825a6ea64d0fad54d949725436098'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
