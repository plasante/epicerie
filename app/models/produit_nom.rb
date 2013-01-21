class ProduitNom < ActiveRecord::Base
  has_many :produits
  
  attr_accessible :nom

  validates :nom, :presence => true
end
