if Rails.env == "development"
	# get credentials from YML file
  S3_CREDENTIALS = Rails.root.join("config/s3.yml")
else
  # set credentials from ENV hash
  S3_CREDENTIALS = { :access_key_id => ENV['S3_KEY'], :secret_access_key => ENV['S3_SECRET'], :bucket => ENV['S3_BUCKET']}
end