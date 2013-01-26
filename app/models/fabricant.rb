class Fabricant < ActiveRecord::Base
  has_many :produits
  
  attr_accessible :nom

  validates :nom, :presence => true,
  				  :length => { :maximum => 100 },
  				  :uniqueness => { :case_sensitive => false }
end
