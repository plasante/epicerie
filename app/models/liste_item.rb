class ListeItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :produit
  
  attr_accessible :qty, :user, :produit

  validates :user, :presence => true
  validates :produit, :presence => true
  validates :qty, :numericality => true
  validates :user_id, :uniqueness => {:scope => :produit_id}

  def self.getMeilleurPrix(current_user)
  	#ActiveRecord::Base.connection.execute("call GetBestPriceByProduct(1,2)")
  	MagasinProduit.all(:limit => 3)
  end
end
