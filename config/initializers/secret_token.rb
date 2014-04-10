# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
def secure_token
	token_file = Rails.root.join('.secret')
	if File.exist?(token_file)
		File.read(token_file).chomp
	else
		token = SecureRandom.hex(64)
		File.write(token_file, token)
		token
	end
end

MonitoringDb::Application.config.secret_key_base = secure_token

#MonitoringDb::Application.config.secret_key_base = 'fa6f3428d96b19fbfae2c94be724e9fbf53a9437875c5debc483f3852cf641e1c2f5f986293d8a8134f847e38f9b3d29cc19e53a10d20011d9abb37cf60dd394'
