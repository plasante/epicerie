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
  
  before_save { |user| user.email = email.downcase }
  
  has_secure_password
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_FIRST_NAME_REGEX = /^[a-z]+$/i
  VALID_LAST_NAME_REGEX = /^[a-z]+$/i
  VALID_USERNAME_REGEX = /^[a-z]+$/i
  
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
end
