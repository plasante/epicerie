require 'spec_helper'

describe Fabricant do
  before {
  	# Je cree un objet de type Fabricant qui sera reutilise partout.
  	@fabricant = Fabricant.new(:nom => 'Quebon')
  }

  subject { @fabricant }

  describe "attributes" do
  	it { should respond_to(:nom) }
  end

  describe "methods" do
  	it { should respond_to(:produits) }
  end

  describe "validation" do
  	describe "when nom is not present" do
  	  before { @fabricant.nom = " " }
  	  it { should_not be_valid }
  	end
  	describe "when nom is too long" do
  	  before { @fabricant.nom = 'a' * 101 }
  	  it { should_not be_valid }
  	end
  	describe "when nom is already taken" do
      before {
        fabricant_avec_meme_nom = @fabricant.dup
        fabricant_avec_meme_nom.save
      }

      it { should_not be_valid }
  	end
  end

  describe "association" do
  	describe "with produits" do
  	  before { @fabricant.save }

  	  let!(:produit1) do
        FactoryGirl.create(:produit, :fabricant => @fabricant)
      end

      let!(:produit2) do
        FactoryGirl.create(:produit, :fabricant => @fabricant)
      end

      it "should have 2 produits" do
        @fabricant.produits.should == [produit1, produit2]
      end
  	end
  end
end
