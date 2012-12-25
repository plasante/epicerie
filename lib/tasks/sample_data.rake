namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    admin = User.create!(:first_name => "Pierre",
                         :last_name  => "Lasante",
                         :username   => "plasante",
                         :email      => "plasante@email.com",
                         :password   => "123456",
                         :password_confirmation => "123456")
    admin.toggle!(:admin)
    99.times do |n|
      first_name = Faker::Name.first_name.downcase
      last_name = Faker::Name.last_name.downcase
      email = "example#{n+1}@email.com"
      password = "123456"
      User.create!(:first_name => first_name,
                   :last_name  => last_name,
                   :username   => "Username",
                   :email      => email,
                   :password   => password,
                   :password_confirmation => password)
    end
    
    users = User.all(:limit => 6)
    50.times do
      content = Faker::Lorem.sentence(5)
      users.each { |user| user.microposts.create!( :content => content ) }
    end
  end
end