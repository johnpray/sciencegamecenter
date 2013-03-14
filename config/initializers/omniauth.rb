Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.production?
  	provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  else
  	provider :facebook, Rails.root.join("config/facebook_key.txt").read, Rails.root.join("config/facebook_secret.txt").read, {:client_options => {:ssl => {:verify => false}}}
  end
end