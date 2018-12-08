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

desc "This task is also called by the Heroku scheduler add-on"
task :delete_old_paper_trail_versions => :environment do
  versions = Version.where("created_at < ?", 1.day.ago).delete_all
end
