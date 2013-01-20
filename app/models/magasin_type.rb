class MagasinType < ActiveRecord::Base
  attr_accessible :nom

  has_many :magasins

  enum_attr :nom, %w(epicerie quincaillerie restaurant)
end
