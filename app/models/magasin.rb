class Magasin < ActiveRecord::Base
  belongs_to :magasin_type

  attr_accessible :description, :nom

  validates :nom, :presence => true,
  			:format => { :with => /[0-9a-zA-Z ']/ },
  			:length => { :minimum => 0, :maximum => 100 }

  validates :description, :length => { :minimum => 0, :maximum => 250 }
end
