require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'My Grocery'" do
      visit '/static_pages/home'
      page.should have_content('My Grocery')
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
  end
end
