# == Schema Information
#
# Table name: manufacturers
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Manufacturer < ActiveRecord::Base
  has_many :produits
  
  attr_accessible :nom

  validates :nom, :presence   => true,
  				  :format     => { :with => /^[a-z0-9]+$/i}
end
