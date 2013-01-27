class MagasinProduit < ActiveRecord::Base
  belongs_to :magasin
  belongs_to :produit
  
  attr_accessible :date_debut, :date_fin, :prix_regulier, :prix_special, :magasin, :produit

  validates :magasin, :presence => true
  validates :produit, :presence => true
  validates :prix_regulier, :numericality => true
  validates :prix_special, :numericality => true
end
