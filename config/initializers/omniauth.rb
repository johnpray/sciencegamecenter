OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
	if Rails.env.production?
  	provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: 'email,user_birthday'
  else
  	provider :facebook, Rails.root.join("config/facebook_key.txt").read, Rails.root.join("config/facebook_secret.txt").read, {scope: 'email,user_birthday', :client_options => {:ssl => {:verify => false}}}
  end
end