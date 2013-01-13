# == Schema Information
#
# Table name: produits
#
#  id              :integer          not null, primary key
#  nom             :string(255)
#  description     :text
#  category_id     :integer
#  manufacturer_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Produit < ActiveRecord::Base
  belongs_to :category
  belongs_to :manufacturer
  
  attr_accessible :description, :nom, :category_id, :manufacturer_id

  validates :category_id, :presence => true
  validates :manufacturer_id, :presence => true
  validates :nom, :presence => true, :length => { :maximum => 140 }
  validates :description, :presence => true, :length => { :maximum => 1000 }
end
