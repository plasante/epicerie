require 'spec_helper'

describe "MicropostPages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in user 
    FactoryGirl.create(:micropost, :user => user, :content => "Lorem ipsum")
  end
  
  
  describe "micropost creation" do
    before(:each) do 
      FactoryGirl.create(:micropost, :user => user, :content => "Lorem ipsum")
      visit root_path
    end
    
    describe "with valid information" do
#      before { fill_in 'micropost_content', :with => "Lorem ipsum" }
#      it "should create a micropost" do
#        expect { click_button I18n.t(:create_post) }.to change(Micropost, :count).by(1)
#      end
    end
  end # of describe "micropost creation"
  
  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, :user => user) }
    
    describe "as correct user" do
      before { visit user_path(user) }
        it "should delete a micropost" do
          expect { click_link I18n.t(:delete_link) }.to change(Micropost, :count).by(-1)
        end
    end
  end
end
