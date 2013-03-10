namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    # make_users
    # make_microposts
    # make_relationships

    # make_magasin_types
    # make_magasins
    # make_produit_noms
    # make_categories
    # make_fabricants
    # make_formats
    # make_produits
    # make_magasins_produits
    # make_liste_items
    make_full_liste
#    make_store_procs
  end
end

def make_users
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.users;")
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
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.microposts;")
  users = User.all(:limit => 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!( :content => content ) }
  end
end

def make_relationships
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.relationships;")
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

def make_full_liste
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.magasin_types;")
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.magasins;")
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.produit_noms;")
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.categories;")
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.fabricants;")
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.formats;")
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.produits;")
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.magasin_produits;")
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.liste_items;")

  magasin_type = MagasinType.create(:nom => 'epicerie')
  
  ['Metro','IGA','Loblaws','Maxi','Super C'].each do |nom|
    magasin_type.magasins.create(:nom => nom, :description => "")
  end

  ['Lait 2%','Oeuf blanc (gros)','Pain blanc tranche','Margarine','Cafe instantane'].each do |nom|
    ProduitNom.create(:nom => nom)
  end

  ['Produits Laitiers','Boulangerie','Cafe The Cacao'].each do |nom|
    Category.create(:nom => nom)
  end

  ['Quebon','Naturoeuf','Weston','Becel','Maxwell House'].each do |nom|
    Fabricant.create(:nom => nom)
  end

  ['2L','12','675g','907g','200g'].each do |nom|
    Format.create(:nom => nom)
  end

  produit_nom_lait = ProduitNom.find(1);
  categorie_produit_laitier = Category.find(1)
  fabricant_lait = Fabricant.find(1);
  format_lait = Format.find(1);
  Produit.create(:produit_nom => produit_nom_lait, :category => categorie_produit_laitier, 
                 :fabricant => fabricant_lait, :format => format_lait,
                 :description => 'Un 2L de Lait 2% Quebon.')

  produit_nom_oeuf = ProduitNom.find(2);
  categorie_produit_laitier = Category.find(1)
  fabricant_oeuf = Fabricant.find(2);
  format_oeuf = Format.find(2);
  Produit.create(:produit_nom => produit_nom_oeuf, :category => categorie_produit_laitier, 
                 :fabricant => fabricant_oeuf, :format => format_oeuf,
                 :description => '12 oeufs blanc gros de marque Naturoeuf.')

  produit_nom_pain = ProduitNom.find(3);
  categorie_boulangerie = Category.find(2)
  fabricant_pain = Fabricant.find(3)
  format_pain = Format.find(3)
  Produit.create(:produit_nom => produit_nom_pain, :category => categorie_boulangerie, 
                 :fabricant => fabricant_pain, :format => format_pain,
                 :description => '1 pain blanc tranche Weston 675g')

  produit_nom_margarine = ProduitNom.find(4);
  categorie_produit_laitier = Category.find(1);
  fabricant_margarine = Fabricant.find(4);
  format_margarine = Format.find(4)
  Produit.create(:produit_nom => produit_nom_margarine, :category => categorie_produit_laitier, 
                 :fabricant => fabricant_margarine, :format => format_margarine,
                 :description => 'Margarine Becel 907g')

  produit_nom_cafe_instant = ProduitNom.find(5);
  categorie_cafe = Category.find(3);
  fabricant_cafe = Fabricant.find(5);
  format_cafe = Format.find(5)
  Produit.create(:produit_nom => produit_nom_cafe_instant, :category => categorie_cafe, 
                 :fabricant => fabricant_cafe, :format => format_cafe,
                 :description => 'Cafe instant Maxwell House 200g')

  # Les 5 magasins offrent les 5 produits. Donc la table magasin_produits aura 25 records.
  magasins = Magasin.all
  produits = Produit.all

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

  user = User.first
  produit1 = Produit.find(1)   # Lait 2% 2L Quebon
  produit2 = Produit.find(2)   # 12 oeufs blanc gros Naturoeuf
  produit3 = Produit.find(3)   # Pain blanc tranche Weston
  produit4 = Produit.find(4)   # Margarine Becel 907g
  produit5 = Produit.find(5)   # Cafe instant Maxwell 200g

  ListeItem.create(:user => user, :produit => produit1, :qty => 1)
  ListeItem.create(:user => user, :produit => produit2, :qty => 1)
  ListeItem.create(:user => user, :produit => produit3, :qty => 1)
  ListeItem.create(:user => user, :produit => produit4, :qty => 1)
  ListeItem.create(:user => user, :produit => produit5, :qty => 1)

  ActiveRecord::Base.connection.execute("update monepicerie_development.magasin_produits
                                         set prix_regulier = 1.0 where id = 1");
  ActiveRecord::Base.connection.execute("update monepicerie_development.magasin_produits
                                         set prix_regulier = 2.0 where id = 7");
  ActiveRecord::Base.connection.execute("update monepicerie_development.magasin_produits
                                         set prix_regulier = 3.0 where id = 13");
  ActiveRecord::Base.connection.execute("update monepicerie_development.magasin_produits
                                         set prix_regulier = 4.0 where id = 19");
  ActiveRecord::Base.connection.execute("update monepicerie_development.magasin_produits
                                         set prix_regulier = 5.0 where id = 25");
end

def make_magasin_types
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.magasin_types;")
  noms = %w(epicerie quincaillerie restaurant)
  noms.each do |nom|
    MagasinType.create(:nom => nom)
  end
end

def make_magasins
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.magasins;")
  noms = %w(Metro IGA Loblaws Maxi SuperC Bonichoix Richelieu Axep Adonis Walmart Costco Esposito 440 InterMarche LeJardin M&M Mourelatos Pasquier Provigo SupermarchePA Tau Tradition Odessa)
  magasin_type = MagasinType.first
  noms.each do |nom|
    magasin_type.magasins.create(:nom => nom, :description => "")
  end
end

def make_produit_noms
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.produit_noms;")
  noms = %w(Lait_ecreme Lait_1% Lait_2% Lait_3.25%)
  noms.each do |nom|
    ProduitNom.create(:nom => nom)
  end
end

def make_categories
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.categories;")
  noms = %w(Produits_Laitiers Viandes Breuvages)
  noms.each do |nom|
    Category.create(:nom => nom)
  end
end

def make_fabricants
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.fabricants;")
  noms = %w(Quebon Lanctatia Grand_Pre Natrel)
  noms.each do |nom|
    Fabricant.create(:nom => nom)
  end
end

def make_formats
  ActiveRecord::Base.connection.execute("truncate monepicerie_development.formats;")
  noms = %w(1L 2L 3x1L)
  noms.each do |nom|
    Format.create(:nom => nom)
  end
end

def make_produits
  produit_noms = ProduitNom.all
  categorie = Category.first
  fabricants = Fabricant.all
  formats = Format.all

  ActiveRecord::Base.connection.execute("truncate monepicerie_development.produits;")
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

def make_magasins_produits
  magasins = Magasin.all
  produits = Produit.all

  ActiveRecord::Base.connection.execute("truncate monepicerie_development.magasin_produits;")
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

# Si un utilisateur n'est pas connecte alors il aura la meme list_items que moi ( user_id = 1 )
def make_liste_items
  user = User.first
  produit1 = Produit.find(2)   # Lait Ecreme 2L
  produit2 = Produit.find(14)   # Lait 1% 2L
  produit3 = Produit.find(26)   # Lait 2% 2L
  produit4 = Produit.find(38)  # Lait 3.25% 2L

  ActiveRecord::Base.connection.execute("truncate monepicerie_development.liste_items;")
  ListeItem.create(:user => user, :produit => produit1, :qty => rand(1..5))
  ListeItem.create(:user => user, :produit => produit2, :qty => rand(1..5))
  ListeItem.create(:user => user, :produit => produit3, :qty => rand(1..5))
  ListeItem.create(:user => user, :produit => produit4, :qty => rand(1..5))
end

def make_store_procs
  ActiveRecord::Base.connection.execute("USE monepicerie_development;")
  ActiveRecord::Base.connection.execute("DROP PROCEDURE IF EXISTS GetBestPriceByProduct;")
  # Pour tester cette procedure qui trouve le meilleur prix pour un 2L de Lait Ecreme
  # call GetBestPriceByProduct(1,2);     -- 1 -> Lait Ecreme   2 -> 2L
  ActiveRecord::Base.connection.execute("CREATE PROCEDURE GetBestPriceByProduct(IN param_produit_nom_id INT, IN param_format_id INT)
                                         BEGIN
                                          select mp.magasin_id, mp.produit_id, mp.prix_regulier
                                          from produits p
                                          join magasin_produits mp on p.id = mp.produit_id
                                          where p.produit_nom_id = param_produit_nom_id
                                          and p.format_id = param_format_id
                                          order by prix_regulier
                                          limit 1;
                                         END")
end