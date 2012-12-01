require 'spec_helper'

describe "Authentication" do
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('h1', :text => I18n.t(:url_sign_in))}
  end
  
  describe "signin" do
    before { visit signin_path }
    
    describe "with invalid information" do
      before { click_button I18n.t(:url_sign_in) }
      
      it { should have_selector('h1', :text => I18n.t(:url_sign_in))}
      it { should have_selector('div.alert.alert-error', :text => I18n.t(:invalid_email_password_combination))}
      
      # Il faut utiliser flash.now pour faire passer ce test.
      describe "after visiting another page" do
        before { click_link I18n.t(:sign_up_now!)}
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in I18n.t(:user_email), :with => user.email
        fill_in I18n.t(:user_password), :with => user.password
        click_button I18n.t(:url_sign_in)
      end
      
      it { should have_link( I18n.t(:url_sign_out), :href => signout_path(user)) }
      it { should_not have_link( I18n.t(:url_sign_in), :href => signin_path) }
      
      describe "followed by signout" do
        before { click_link I18n.t(:url_sign_out) }
        it { should_not have_link( I18n.t(:url_sign_out), :href => signout_path(user)) }
        it { should have_link( I18n.t(:url_sign_in), :href => signin_path) }
      end
    end
  end
end
