require 'spec_helper'

describe "StaticPages" do
  subject { page }
  
  describe "Home page" do
    it "should have the content 'My Grocery'" do
      visit home_path
      should have_content('My Grocery')
    end
    
    describe "for signed-in users" do
#      let(:user) { FactoryGirl.create(:user) }
#      
#      before do
#        FactoryGirl.create(:micropost, :user => user, :content => "Lorem ipsum")
#        FactoryGirl.create(:micropost, :user => user, :content => "Dolor sit amet")
#        sign_in user
#        visit root_path
#      end
#      
#      it "should render the user's feed" do
#        user.feed.each do |item|
#          page.should have_selector("li##{item.id}", :text => item.content)
#        end
#      end
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit help_path
      should have_content('Help')
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit about_path
      should have_content('About Us')
    end
  end
  
  describe "Contact page" do
    it "should have the H1 'Contact'" do
      visit contact_path
      should have_selector("h1", :text => 'Contact')
    end
  end
end
