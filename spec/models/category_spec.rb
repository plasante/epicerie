require 'spec_helper'

describe Category do

  before {
  	# Je cree un objet de type Category qui sera reutilise partout.
  	@category = Category.new(:nom => 'Viandes')
  }

  subject { @category }

  describe "attributes" do
  	it { should respond_to(:nom) }
  end

  describe "methods" do
  	it { should respond_to(:produits) }
  end

  describe "validation" do
  	describe "when nom is not present" do
  	  before { @category.nom = " " }
  	  it { should_not be_valid }
  	end
  	describe "when nom is too long" do
  	  before { @category.nom = 'a' * 101 }
  	  it { should_not be_valid }
  	end
  	describe "when nom is already taken" do
      before {
        category_avec_meme_nom = @category.dup
        category_avec_meme_nom.save
      }

      it { should_not be_valid }
  	end
  end

  describe "association" do
  	describe "with produits" do
  	  before { @category.save }

  	  let!(:produit1) do
        FactoryGirl.create(:produit, :category => @category)
      end

      let!(:produit2) do
        FactoryGirl.create(:produit, :category => @category)
      end

      it "should have 2 produits" do
        @category.produits.should == [produit1, produit2]
      end
  	end
  end
end
