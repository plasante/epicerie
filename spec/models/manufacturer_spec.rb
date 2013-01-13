# == Schema Information
#
# Table name: manufacturers
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Manufacturer do
  before {
  	@category = Category.new( :nom => 'nom')
  	@manufacturer = Manufacturer.new( :nom => 'nom')
  }

  subject { @manufacturer }

  it { should respond_to(:nom) }

  describe "when nom is not present" do
  	before { @manufacturer.nom = " " }
  	it { should_not be_valid }
  end

  describe "when nom has invalid character" do
  	before { @manufacturer.nom = "Kraft<"}
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
    	@manufacturer.produits.should == [produit]
    end
  end
end
