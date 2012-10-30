require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector("h1", :text => 'Sign up')}
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    
    it { should have_selector("h2", :text => user.first_name) }
    it { should have_selector("h2", :text => user.last_name) }
  end
  
  describe "signup page" do
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    describe "with invalid information>" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "first_name",               :with => "Pierre"
        fill_in "last_name",                :with => "Lasante"
        fill_in "username",                 :with => "plasante"
        fill_in "email",                    :with => "plasante@email.com"
        fill_in "password",                 :with => "123456"
        fill_in "password_confirmation",    :with => "123456"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
    
  end
end