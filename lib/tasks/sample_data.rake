namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "John Pray",
                 email: "jpray@fas.org",
                 password: "pikachu",
                 birth_date: Date.new(1989, 01, 30))
    admin.toggle!(:is_admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "jpray+#{n+1}@fas.org"
      password  = "password"
      birth_date = Date.new(1980, 01, 01)
      User.create!(name: name,
                   email: email,
                   password: password,
                   birth_date: birth_date)
    end
    50.times do |n|
      title = Faker::Lorem.words(1 + Random.rand(5)).join(" ").titleize
      Game.create(title: title)
    end
  end
end