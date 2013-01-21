class ListeItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :produit
  
  attr_accessible :qty
end
