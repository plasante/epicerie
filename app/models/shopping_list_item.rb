# == Schema Information
#
# Table name: shopping_list_items
#
#  id                 :integer          not null, primary key
#  shopping_list_id   :integer
#  magasin_produit_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class ShoppingListItem < ActiveRecord::Base
  belongs_to :shopping_list
  belongs_to :magasin_produit
  
  # attr_accessible :title, :body
end
