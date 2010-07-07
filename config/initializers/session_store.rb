# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_loja_session',
  :secret      => '5026825ab4e632a48fedc1aa5c589e664bc8c6e2a3baedaefcc75e5592dd4d402e997ae72e3aed52ed8ba7b4cdf1f874d5f24dea52c8b974b8419ffd21a05372'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
