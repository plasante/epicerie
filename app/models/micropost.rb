class Micropost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  validates :content, :presence => true, :length => { :maximum => 140 }
  validates :user_id, :presence => true
  
  default_scope :order => 'microposts.created_at DESC'
  
  # Returns microposts from the users being followed by the give user
  def self.from_users_followed_by(user)
    # creates an array the full length of the followed users array.
    # It does not scale right if there are 5000 users being followed.
    #followed_user_ids = user.followed_user_ids
    # We use a subselect to force the heavylifting made by the database.
    # On the other hand we may need to generate feed asynchronously using a thread.
    followed_user_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id", :user_id => user)
  end
end
