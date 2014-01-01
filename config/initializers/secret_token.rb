# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Stormsavvy::Application.config.secret_token='3987930edc64fedc4cc8a510be09cdce08b28fe59376164f37789233ece07f300989e8235a62240dd3657cb8692e64827ad3fafd92f137324c55e76525fff6ba'
# Stormsavvy::Application.config.secret_key_base = 
#   '91ea1d359bed0b4897a1450cd87c346ddbd9166740370d3b292299ced0cd619e98313e05ddf3eef0320ac52c57382f67011d26ea7cbee75ef2759082e249ef34'
# Stormsavvy::Application.config.secret_token = ENV['SECRET_TOKEN']

# Stormsavvy::Application.config.secret_token = if Rails.env.development? or Rails.env.test?
#   ('x' * 30) # meets minimum requirement of 30 chars long
# else
#   ENV['SECRET_TOKEN']
# end
