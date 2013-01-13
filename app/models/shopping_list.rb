# == Schema Information
#
# Table name: shopping_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShoppingList < ActiveRecord::Base
  belongs_to :user
  has_many :shopping_list_items
  
  # attr_accessible :title, :body
end
