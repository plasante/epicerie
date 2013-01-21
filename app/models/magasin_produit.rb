class MagasinProduit < ActiveRecord::Base
  belongs_to :magasin
  belongs_to :produit
  
  attr_accessible :date_debut, :date_fin, :prix_regulier, :prix_special
end
