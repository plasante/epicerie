require 'spec_helper'

describe "SavemoneyPages" do
  subject { page }
  
  before do
    visit root_path
    click_button(I18n.t(:save_money_button))
  end
  
  it { should have_selector('div.save_money_result', :text => "Yo")}
  
end
