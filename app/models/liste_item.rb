class ListeItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :produit
  
  attr_accessible :qty, :user, :produit

  validates :user, :presence => true
  validates :produit, :presence => true
  validates :qty, :numericality => true
end
