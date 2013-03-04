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
  	# Etablit la liste de produit_id d'un usager (select produit_id from liste_items;)
  	liste_produits = ListeItem.select("produit_id").where("user_id = :user_id", :user_id => user).map(&:produit_id)
    # Pour trouver le meilleur prix pour lait_ecreme 1% 2% et 3.25% en format 2L
    # en faisant abstraction du fabricant.
    #liste_produits = [2,14,26,38]
    liste_produits.each do |liste_produit|
      # Extrait produit_nom_id et format_id du produit
  	  produit = Produit.select("produit_nom_id, format_id").where("id = #{liste_produit}")
      sous_select = "SELECT id FROM produits WHERE produit_nom_id = #{produit[0][:produit_nom_id]} AND format_id = #{produit[0][:format_id]}"
	  magasin_produits << MagasinProduit.where("produit_id IN (#{sous_select})").order("prix_regulier ASC").limit("1")
  	end
    magasin_produits
  end
end
