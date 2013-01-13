# == Schema Information
#
# Table name: magasin_types
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MagasinType < ActiveRecord::Base
	has_many :magasins

  	attr_accessible :nom
end
