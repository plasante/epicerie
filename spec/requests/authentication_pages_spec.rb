require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('h1', :text => 'Sign in')}
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button :url_sign_in }
      
      it { should have_selector('h1', :text => 'Sign in')}
      it { should have_selector('div.alert.alert-error', :text => 'Invalid')}
      
      # Il faut utiliser flash.now pour faire passer ce test.
      describe "after visiting another page" do
        before { click_link I18n.t(:sign_up_now!)}
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password
        click_button :url_sign_in
      end
      
      it { should have_link( I18n.t(:url_sign_out), :href => signout_path(user)) }
      it { should_not have_link( I18n.t(:url_sign_in), :href => signin_path) }
      
    end
  end
end
