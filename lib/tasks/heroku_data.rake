namespace :db do
  desc "Fill database with sample data"
  task :heroku => :environment do
    make_heroku_users

    make_heroku_magasin_types
    make_heroku_magasins
    make_heroku_produit_noms
    make_heroku_categories
    make_heroku_fabricants
    make_heroku_formats
    make_heroku_produits
    make_heroku_magasins_produits
    make_heroku_liste_items
#    make_store_procs
  end
end

def make_heroku_users
  ActiveRecord::Base.connection.execute("truncate users RESTART IDENTITY;")
  admin = User.create!(:first_name => "Pierrot",
                       :last_name  => "Lasante",
                       :username   => "plasante",
                       :email      => "plasante@email.com",
                       :password   => "123456",
                       :password_confirmation => "123456")
  admin.toggle!(:admin)
end

def make_heroku_magasin_types
  ActiveRecord::Base.connection.execute("truncate magasin_types RESTART IDENTITY;")
  noms = %w(epicerie quincaillerie restaurant)
  noms.each do |nom|
    MagasinType.create(:nom => nom)
  end
end

def make_heroku_magasins
  ActiveRecord::Base.connection.execute("truncate magasins RESTART IDENTITY;")
  noms = %w(Metro IGA Loblaws Maxi SuperC Bonichoix Richelieu Axep Adonis Walmart Costco Esposito 440 InterMarche LeJardin M&M Mourelatos Pasquier Provigo SupermarchePA Tau Tradition Odessa)
  magasin_type = MagasinType.first
  noms.each do |nom|
    magasin_type.magasins.create(:nom => nom, :description => "")
  end
end

def make_heroku_produit_noms
  ActiveRecord::Base.connection.execute("truncate produit_noms RESTART IDENTITY;")
  noms = %w(Lait_ecreme Lait_1% Lait_2% Lait_3.25%)
  noms.each do |nom|
    ProduitNom.create(:nom => nom)
  end
end

def make_heroku_categories
  ActiveRecord::Base.connection.execute("truncate categories RESTART IDENTITY;")
  noms = %w(Produits_Laitiers Viandes Breuvages)
  noms.each do |nom|
    Category.create(:nom => nom)
  end
end

def make_heroku_fabricants
  ActiveRecord::Base.connection.execute("truncate fabricants RESTART IDENTITY;")
  noms = %w(Quebon Lanctatia Grand_Pre Natrel)
  noms.each do |nom|
    Fabricant.create(:nom => nom)
  end
end

def make_heroku_formats
  ActiveRecord::Base.connection.execute("truncate formats RESTART IDENTITY;")
  noms = %w(1L 2L 3x1L)
  noms.each do |nom|
    Format.create(:nom => nom)
  end
end

def make_heroku_produits
  produit_noms = ProduitNom.all
  categorie = Category.first
  fabricants = Fabricant.all
  formats = Format.all

  ActiveRecord::Base.connection.execute("truncate produits RESTART IDENTITY;")
  produit_noms.each do |produit_nom|
    fabricants.each do |fabricant|
      formats.each do |format|
        Produit.create(:produit_nom => produit_nom,
                       :category => categorie,
                       :fabricant => fabricant,
                       :format => format)
      end
    end
  end
end

def make_heroku_magasins_produits
  magasins = Magasin.all
  produits = Produit.all

  ActiveRecord::Base.connection.execute("truncate magasin_produits RESTART IDENTITY;")
  magasins.each do |magasin|
    produits.each do |produit|
      MagasinProduit.create(:magasin => magasin,
                            :produit => produit,
                            :prix_regulier => rand(6..10),
                            :prix_special => rand(1..5),
                            :date_debut => '2013-01-01',
                            :date_fin => '2013-01-07')
    end
  end
end

def make_heroku_liste_items
  user = User.first
  produit1 = Produit.find(2)   # Lait Ecreme 2L
  produit2 = Produit.find(14)   # Lait 1% 2L
  produit3 = Produit.find(26)   # Lait 2% 2L
  produit4 = Produit.find(38)  # Lait 3.25% 2L

  ActiveRecord::Base.connection.execute("truncate liste_items RESTART IDENTITY;")
  ListeItem.create(:user => user, :produit => produit1, :qty => rand(1..5))
  ListeItem.create(:user => user, :produit => produit2, :qty => rand(1..5))
  ListeItem.create(:user => user, :produit => produit3, :qty => rand(1..5))
  ListeItem.create(:user => user, :produit => produit4, :qty => rand(1..5))
end