class Fabricant < ActiveRecord::Base
  has_many :produits
  
  attr_accessible :nom
end
