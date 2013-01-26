class Produit < ActiveRecord::Base
  belongs_to :produit_nom
  belongs_to :category
  belongs_to :fabricant
  belongs_to :format
  
  attr_accessible :description, :produit_nom, :category, :fabricant, :format

  validates :description, :length => { :minimum => 0, :maximum => 255 }
end
