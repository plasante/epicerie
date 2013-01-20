namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    make_users
    make_microposts
    make_relationships
    make_magasin_types
    make_magasins
  end
end

def make_users
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
end

def make_microposts
  users = User.all(:limit => 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!( :content => content ) }
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_magasin_types
  noms = %w(epicerie quincaillerie restaurant)
  noms.each do |nom|
    MagasinType.create(:nom => nom)
  end
end

def make_magasins
  noms = %w(Metro IGA Loblaws Maxi SuperC)
  magasin_type = MagasinType.first
  noms.each do |nom|
    magasin_type.magasins.create(:nom => nom, :description => "")
  end
end
