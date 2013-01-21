class Produit < ActiveRecord::Base
  belongs_to :produit_nom
  belongs_to :category
  belongs_to :fabricant
  belongs_to :format
  
  attr_accessible :description
end
