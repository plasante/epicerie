# == Schema Information
#
# Table name: magasin_produits
#
#  id            :integer          not null, primary key
#  magasin_id    :integer
#  produit_id    :integer
#  quantity      :integer          default(1)
#  prix_regulier :decimal(12, 2)   default(0.0)
#  prix_special  :decimal(12, 2)   default(0.0)
#  date_debut    :date
#  date_fin      :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class MagasinProduit < ActiveRecord::Base
  belongs_to :magasin
  belongs_to :produit
  belongs_to :shopping_list_item

  attr_accessible :date_debut, :date_fin, :prix_regulier, :prix_special, :quantity
end
