# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  username   :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :username, :password, :password_confirmation
  has_many :microposts, :dependent => :destroy
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :followed_users, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id", :class_name => "Relationship", :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  before_save { |user| user.email = email.downcase }
  
  has_secure_password
  
  before_save :create_remember_token
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_FIRST_NAME_REGEX = /^[a-z0-9]+$/i
  VALID_LAST_NAME_REGEX = /^[a-z'0-9]+$/i
  VALID_USERNAME_REGEX = /^[a-z0-9]+$/i
  
  validates :first_name, :presence   => true, 
                         :length     => { :maximum => 50 },
                         :format     => { :with => VALID_FIRST_NAME_REGEX}
  validates :last_name,  :presence   => true, 
                         :length     => { :maximum => 50 },
                         :format     => { :with => VALID_LAST_NAME_REGEX}
  validates :username,   :presence   => true, 
                         :length     => { :maximum => 50 },
                         :format     => { :with => VALID_USERNAME_REGEX}
  validates :email,      :presence   => true, 
                         :format     => { :with => VALID_EMAIL_REGEX },
                         :uniqueness => { :case_sensitive => false }
  validates :password,   :presence   => true,
                         :length     => { :minimum => 6 }
  validates :password_confirmation, :presence => true
  
  def feed
    Micropost.where("user_id = ?", id)
  end
  
  def following?(other_user)
    self.relationships.find_by_followed_id(other_user.id)
  end
  
  def follow!(other_user)
    self.relationships.create!(:followed_id => other_user.id)
  end
  
  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end
  
  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
