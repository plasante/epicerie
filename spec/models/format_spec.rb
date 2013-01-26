require 'spec_helper'

describe Format do
  before {
  	# Je cree un objet de type Format qui sera reutilise partout.
  	@format = Format.new(:nom => '2L')
  }

  subject { @format }

  describe "attributes" do
  	it { should respond_to(:nom) }
  end

  describe "methods" do
  	it { should respond_to(:produits) }
  end

  describe "validation" do
  	describe "when nom is not present" do
  	  before { @format.nom = " " }
  	  it { should_not be_valid }
  	end
  	describe "when nom is too long" do
  	  before { @format.nom = 'a' * 21 }
  	  it { should_not be_valid }
  	end
  	describe "when nom is already taken" do
      before {
        format_avec_meme_nom = @format.dup
        format_avec_meme_nom.save
      }

      it { should_not be_valid }
  	end
  end

  describe "association" do
  	describe "with produits" do
  	  before { @format.save }

  	  let!(:produit1) do
        FactoryGirl.create(:produit, :format => @format)
      end

      let!(:produit2) do
        FactoryGirl.create(:produit, :format => @format)
      end

      it "should have 2 produits" do
        @format.produits.should == [produit1, produit2]
      end
  	end
  end
end
