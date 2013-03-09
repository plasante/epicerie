namespace :db do
  desc "Fill database with sample data"
  task :heroku => :environment do
    make_heroku_users

#    make_heroku_magasin_types
#    make_magasins
#    make_produit_noms
#    make_categories
#    make_fabricants
#    make_formats
#    make_produits
#    make_magasins_produits
#    make_liste_items
#    make_store_procs
  end
end

def make_heroku_users
  ActiveRecord::Base.connection.execute("truncate users;")
  admin = User.create!(:first_name => "Pierrot",
                       :last_name  => "Lasante",
                       :username   => "plasante",
                       :email      => "plasante@email.com",
                       :password   => "123456",
                       :password_confirmation => "123456")
  admin.toggle!(:admin)
end