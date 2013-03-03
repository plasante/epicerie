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
  	magasin_produits = []
  	liste_items = ListeItem.select("produit_id").where("user_id = :user_id", :user_id => user).map(&:produit_id)
    # Pour trouver le meilleur prix pour lait_ecreme 1% 2% et 3.25% en format 2L
    #liste_items = [2,14,26,38]
    liste_items.each do |liste_item|
  	  produit = Produit.select("produit_nom_id, format_id").where("id = #{liste_item}")
      sous_select = "SELECT id FROM produits WHERE produit_nom_id = #{produit[0][:produit_nom_id]} AND format_id = #{produit[0][:format_id]}"
	  magasin_produits << MagasinProduit.where("produit_id IN (#{sous_select})").order("prix_regulier ASC").limit("1")
  	end
    magasin_produits
  end
end
