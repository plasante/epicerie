require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }
    
    describe "followed users " do
      before do
        sign_in user
        visit following_user_path(user)
      end
      
      it { should have_selector('h3', :text => I18n.t(:following)) }
      it { should have_link(other_user.first_name, :href => user_path(other_user)) }
    end
    
    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end
      
      it { should have_selector('h3', :text => I18n.t(:followers)) }
      it { should have_link(user.first_name, :href => user_path(user)) }
    end
  end # of describe following/followers
  
  describe "index" do
    
    let(:user) { FactoryGirl.create(:user) }
    
    before(:each) do
      sign_in user
      visit users_path
    end
    
    it { should have_selector('h1', :text => I18n.t(:all_users))}
    it { should have_selector('h2', :text => I18n.t(:all_users))}
    
    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }
      
      it { should have_selector('div.pagination') }
      
      it "should list each user" do
        User.paginate(:page => 1).each do |user|
          page.should have_selector('li', :text => user.first_name)
        end
      end
    end
    
    describe "delete links" do
      it { should_not have_link( I18n.t(:delete_link)) }
      
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        
        it { should have_link( I18n.t(:delete_link), :href => user_path(User.first)) }
        it "should be able to delete another user" do
          expect { click_link( I18n.t(:delete_link)) }.to change(User, :count).by(-1)
        end
        it { should_not have_link( I18n.t(:delete_link), :href => user_path(admin)) }
      end
      
      describe "as non-admin user" do
        let(:user) { FactoryGirl.create(:user) }
        let(:non_admin) { FactoryGirl.create(:user) }
        
        before { sign_in non_admin }
        
        describe "submitting a DELETE request to the Users#destroy action" do
          before { delete user_path(user) }
          specify { response.should redirect_to(root_path) }
        end
      end
    end
    
  end # of describe "index"
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector("h1", :text => 'Sign up')}
  end
  
  describe "edit" do
    # Creation d'un usager la bd test
    let(:user) { FactoryGirl.create(:user) }
    before { 
      sign_in user
      visit edit_user_path(user) 
    }
    
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
    let!(:m1) { FactoryGirl.create(:micropost, :user => user, :content => "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, :user => user, :content => "Bar") }
    
    before { visit user_path(user) }
    
    it { should have_selector("h2", :text => user.first_name) }
    it { should have_selector("h2", :text => user.last_name) }
    
    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      # user.microposts.count counts directly in the database
      # if it becomes a bottleneck then make it faster with counter cache
      it { should have_content(user.microposts.count) }
    end
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
