require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector("h1", :text => 'Sign up')}
  end
  
  describe "edit" do
    # Creation d'un usager la bd test
    let(:user) { FactoryGirl.create(:user) }
    before { visit edit_user_path(user) }
    
    describe "page" do
      it { should have_selector('h1', :text => I18n.t(:update_your_profile)) }
      it { should have_selector('h2', :text => I18n.t(:edit_user)) }
    end
    
    describe "with invalid information" do
      before { click_button I18n.t(:save_user_changes) }
      it { should have_content('error') }
    end
    
    describe "with valid information" do
      let(:new_first_name) { "Pierrot" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "user_first_name",               :with => new_first_name
        fill_in "user_last_name",                :with => "Lasante"
        fill_in "user_username",                 :with => "plasante"
        fill_in "user_email",                    :with => new_email
        fill_in "user_password",                 :with => "123456"
        fill_in "user_password_confirmation",    :with => "123456"
        click_button I18n.t(:save_user_changes)
      end
      
      it { should have_selector('div.alert.alert-success') }
      specify { user.reload.first_name.should == new_first_name }
      specify { user.reload.email.should == new_email }
    end
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
        fill_in "user_first_name",               :with => "Pierre"
        fill_in "user_last_name",                :with => "Lasante"
        fill_in "user_username",                 :with => "plasante"
        fill_in "user_email",                    :with => "plasante@email.com"
        fill_in "user_password",                 :with => "123456"
        fill_in "user_password_confirmation",    :with => "123456"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        it { should have_link( I18n.t(:url_sign_out) ) }
      end
    end
    
  end
end
