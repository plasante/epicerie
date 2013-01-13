# == Schema Information
#
# Table name: magasins
#
#  id              :integer          not null, primary key
#  nom             :string(255)
#  description     :text
#  magasin_type_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Magasin < ActiveRecord::Base
  belongs_to :magasin_type
  has_many :magasin_produits
  
  attr_accessible :description, :nom
end
