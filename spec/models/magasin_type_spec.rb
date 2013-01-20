require 'spec_helper'

describe MagasinType do
  
  before {
  	@magasin_type = MagasinType.new(:nom => 'epicerie')
  }

  subject { @magasin_type }

  it { should be_valid }

  it { should respond_to(:nom) }

  describe "magasins associations" do
  	before { @magasin_type.save }

  	# The "let bang" method makes sure @magasin_type.magasins collection is not empty
  	let!(:magasin) do
  	  FactoryGirl.create(:magasin, :magasin_type => @magasin_type)
  	end

  	it "should have a magasin" do
  	  # We normally expect an array of objects to be returned.
  	  @magasin_type.magasins.should == [magasin]
  	end
  end
end
