require 'spec_helper'

describe "MicropostPages" do
  subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  
  describe "micropost creation" do
    before { visit root_path }
    
    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button I18n.t(:create_post) }.not_to change(Micropost, :count)
      end
      
      describe "error messages" do
        before { click_button I18n.t(:create_post) }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before { fill_in 'micropost_content', :with => "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button I18n.t(:create_post) }.to change(Micropost, :count).by(1)
      end
    end
  end # of describe "micropost creation"
end
