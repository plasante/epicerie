class MagasinProduit < ActiveRecord::Base
  belongs_to :magasin
  belongs_to :produit
  
  attr_accessible :date_debut, :date_fin, :prix_regulier, :prix_special, :magasin, :produit

  validates :magasin, :presence => true
  validates :produit, :presence => true
  validates :prix_regulier, :numericality => true
  validates :prix_special, :numericality => true

  #
  # Une liste de magasins ayant le plus bas prix sera affiche a l'ecran.
  #
  def self.getMeilleurPrix( user )
    if (user.nil?) 
      user = User.first
    end
  	magasin_liste = []
  	liste_items = ListeItem.select("produit_id").where("user_id = :user_id", :user_id => user)
    liste_items.each do |liste_item|
	  sous_select = "SELECT id FROM produits 
	                 WHERE produit_nom_id = #{liste_item.produit.produit_nom_id} 
	                 AND format_id = #{liste_item.produit.format_id}"
	  magasin_liste << MagasinProduit.where("produit_id IN (#{sous_select})").order("prix_regulier ASC").limit("1")
  	end
    magasin_liste
  end

  def self.getWorstPrix( user )
    if (user.nil?) 
      user = User.first
    end
    magasin_liste = []
    liste_items = ListeItem.select("produit_id").where("user_id = :user_id", :user_id => user)
    liste_items.each do |liste_item|
    sous_select = "SELECT id FROM produits 
                   WHERE produit_nom_id = #{liste_item.produit.produit_nom_id} 
                   AND format_id = #{liste_item.produit.format_id}"
    magasin_liste << MagasinProduit.where("produit_id IN (#{sous_select})").order("prix_regulier DESC").limit("1")
    end
    magasin_liste
  end
end
