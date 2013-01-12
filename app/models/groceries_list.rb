# == Schema Information
#
# Table name: groceries_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class GroceriesList < ActiveRecord::Base
  belongs_to :user
  # attr_accessible :title, :body
end
