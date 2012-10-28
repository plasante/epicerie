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

require 'spec_helper'

describe User do
  before { @user = User.new(:first_name=>"Pierre", 
                            :last_name=>"Lasante", 
                            :username=>"plasante", 
                            :email=>"plasante@email.com")}
  subject { @user }
  
  it { should respond_to(:first_name)}
  it { should respond_to(:last_name)}
  it { should respond_to(:username)}
  it { should respond_to(:email)}
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @user.first_name = " ",
             @user.last_name = " ",
             @user.username = " "}
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end
  
  describe "when first_name has invalid characters" do
    before { @user.first_name = "pierre@"}
    it { should_not be_valid }
  end
  
  describe "when last_name has invalid characters" do
    before { @user.last_name = "plasante!"}
    it { should_not be_valid }
  end
  
  describe "when username has invalid characters" do
    before { @user.username = "'plasante"}
    it { should_not be_valid }
  end
  
  describe "when first_name is too long" do
    before { @user.first_name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when last_name is too long" do
    before { @user.last_name = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when username is too long" do
    before { @user.username = "a" * 51 }
    it { should_not be_valid }
  end
  
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+bar.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end
  
  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.com A_US-ER@f.b.org frst.lst@foo.jp a+b@bax.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end
  
  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
end
