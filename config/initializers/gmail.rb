if Rails.env == "production"
  # set credentials from ENV hash
  GMAIL_USERNAME = ENV['GMAIL_USERNAME']
  GMAIL_PASSWORD = ENV['GMAIL_PASSWORD']
else
  # get credentials from YML file
  GMAIL_USERNAME = Rails.root.join("config/gmail_username.txt")
  GMAIL_PASSWORD = Rails.root.join("config/gmail_password.txt")
end