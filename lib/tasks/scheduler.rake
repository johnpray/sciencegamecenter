desc "This task is called by the Heroku scheduler add-on"
task :delete_disabled_underage_users => :environment do
	puts "Started delete_disabled_underage_users"
  users = User.where(disabled: true).where("created_at < ?", 30.days.ago)
  users.each do |user|
  	if (user.created_at - user.birthdate.to_datetime) < 13.years
  		user.destroy
  		puts "Automatically destroyed #{user}"
  	end
  end
  puts "Finished delete_disabled_underage_users"
end