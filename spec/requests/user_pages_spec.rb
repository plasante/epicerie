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
end
