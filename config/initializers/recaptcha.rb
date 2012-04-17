if Rails.env == "production"
  # set credentials from ENV hash
  Recaptcha.configure do |config|
	  config.public_key  = ENV['RECAPTCHA_PUBLIC']
	  config.private_key = ENV['RECAPTCHA_PRIVATE']
	end
else
  # get credentials from YML file
  Recaptcha.configure do |config|
	  config.public_key  = Rails.root.join("config/recaptcha_public.txt").read
	  config.private_key = Rails.root.join("config/recaptcha_private.txt").read
	end
end