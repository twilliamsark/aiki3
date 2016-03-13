# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
# Aiki3::Application.config.secret_key_base = 'a20821cc4e0b84888ddeb3a8ed0a969002906e87e9c8eed9acc14b79be0ac138308adbe190a7212e8db11b1af1ee674dd5645919148140da0c01265f04b2f5c5'

#Michael Hartl. Ruby on Rails Tutorial (Kindle Locations 2115-2130). railstutorial.org.
require 'securerandom'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file) # Use the existing token.
    File.read(token_file).chomp
  else # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Aiki3::Application.config.secret_key_base = secure_token
