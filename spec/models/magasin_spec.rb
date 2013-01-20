require 'spec_helper'

describe Magasin do

  # Construction d'un objet valide
  before {
  	@magasin = Magasin.new( :nom => 'Metro', :description => 'Description' )
  }

  subject { @magasin }

  it { should be_valid }

  it { should respond_to(:nom) }
  it { should respond_to(:description) }

  describe "when nom is not present" do
  	before {
  		@magasin.nom = " "
  	}
  	it { should_not be_valid }
  end

  describe "when nom has invalid characters" do
  	before {
  		@magasin.nom = "&*^^"
  	}
  	it { should_not be_valid }
  end

  describe "when nom is too long" do
  	before { @magasin.nom = "a" * 101 }
  	it { should_not be_valid }
  end

  describe "when description is too long" do
  	before { @magasin.description = "a" * 251 }
  	it { should_not be_valid }
  end

  describe "magasin_types associations" do

  	# The attribute id of magasin_type will have a valid value.
  	let(:magasin_type) { FactoryGirl.create(:magasin_type, :nom => 'epicerie') }
  	# The magasin_type_id attribute will have a valid value.
  	let(:magasin) { FactoryGirl.create(:magasin, :nom => 'IGA', :magasin_type => magasin_type) }

  	subject { magasin }

  	it { should be_valid }

  	it "should belong to magasin_type" do
  		# We expect a single object to be returned ( magasin_type )
  		magasin.magasin_type.should == magasin_type
  	end
  end
end
