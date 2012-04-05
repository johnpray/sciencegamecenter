namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "John Pray",
                 email: "jpray@fas.org",
                 password: "pikachu")
    admin.toggle!(:is_admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "jpray+#{n+1}@fas.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password)
    end
  end
end