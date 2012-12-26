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
      
      it { should have_link( I18n.t(:users), :href => users_path) }
      it { should have_link( I18n.t(:url_sign_out), :href => signout_path(user)) }
      it { should_not have_link( I18n.t(:url_sign_in), :href => signin_path) }
      
      describe "followed by signout" do
        before { click_link I18n.t(:url_sign_out) }
        it { should_not have_link( I18n.t(:url_sign_out), :href => signout_path(user)) }
        it { should have_link( I18n.t(:url_sign_in), :href => signin_path) }
      end
    end
  end # of describe "signin"
  
  describe "with valid information" do
    let(:user) { FactoryGirl.create(:user) }
    # We visit signin_path and then root_path
    before { sign_in user }
    
    # We expect the following links to be defined in root_path
    it { should have_link( I18n.t(:url_sign_out), :href => signout_path(user)) }
    it { should_not have_link( I18n.t(:url_sign_in), :href => signin_path) }
  end
  
  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      
      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in I18n.t(:user_email), :with => user.email
          fill_in I18n.t(:user_password), :with => user.password
          click_button I18n.t(:url_sign_in)
        end
        
        describe "after signing in" do
          it "should render the desired protected page" do
            page.should have_selector('h2', :text => I18n.t(:edit_user))
          end
        end
      end
      
      describe "visiting the edit page" do
        before { visit edit_user_path(user) }
        it { should have_selector('h1', :text => I18n.t(:url_sign_in))}
      end
      
      describe "submitting to the update action" do
        before { put user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
      
      describe "in the Users controller" do
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('h1', :text => I18n.t(:url_sign_in)) }
        end
      end
      
      describe "in the Microposts controller" do
        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path) }
        end
        describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { response.should redirect_to(signin_path) }
        end
      end
    end # of describe for non-signed-in users
    
    describe "as wrong users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, :email => "wrong@example.com") }
      before { sign_in user }
      
      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_selector('h2', :text => I18n.t(:edit_user)) }
      end
      
      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end # of describe as wrong users
  end # of describe authorization
end
