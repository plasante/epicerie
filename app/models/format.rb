class Format < ActiveRecord::Base
  has_many :produits
  
  attr_accessible :nom

  validates :nom, :presence => true,
  				  :length => { :maximum => 20 },
  				  :uniqueness => { :case_sensitive => false }
end
