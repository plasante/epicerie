# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Category do
  
  before {
  	@category = Category.new( :nom => 'nom')
  	@manufacturer = Manufacturer.new( :nom => 'nom')
  }

  subject { @category }

  it { should respond_to(:nom) }

  describe "when nom is not present" do
  	before { @category.nom = " " }
  	it { should_not be_valid }
  end

  describe "when nom has invalid character" do
  	before { @category.nom = "Fruits<"}
    it { should_not be_valid }
  end

  describe "produits associations" do
  	before { 
  		@category.save 
  		@manufacturer.save 
  	}

  	let!(:produit) do
      FactoryGirl.create(:produit, :nom => 'nom', 
      							   :description => 'description', 
      							   :category => @category, 
      							   :manufacturer => @manufacturer)
    end

    it "should have the right produit" do
    	@category.produits.should == [produit]
    end
  end
end
