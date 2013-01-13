# == Schema Information
#
# Table name: shopping_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe ShoppingList do
	let(:user) { FactoryGirl.create(:user) }

	# On check que les associations entre users et shopping_lists tables sont bien definies.

	# has_many :shopping_lists ( devrait etre dans user.rb)
	before { @shopping_list = user.shopping_lists.build }

	subject { @shopping_list }

	it { should respond_to(:user_id) }

	# belongs_to :user ( devrait etre dans shopping_list.rb )
	it { should respond_to(:user) }
end
