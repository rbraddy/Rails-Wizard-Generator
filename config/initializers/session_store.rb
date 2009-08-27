# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_generator_session',
  :secret      => '147fbe897e18779dd49a8ead8faf2de38ca5c44469986a043a636bceb427cc3da92636b92c8c17a8aab8ca3524ac8dae76f2caadabe0278aadbe3a723b4a46d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
