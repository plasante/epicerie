require 'spec_helper'

describe ProduitNom do
  before {
  	@produit_nom = ProduitNom.new(:nom => 'Lait ecreme')
  }

  subject { @produit_nom }

  it { should be_valid }

  it { should respond_to(:nom) }

  describe "when nom is not present" do
  	before { @produit_nom.nom = " " }
  	it { should_not be_valid }
  end

  describe "when nom is nil" do
    before { @produit_nom.nom = nil }
    it { should_not be_valid }
  end

  describe "when nom is too long" do
    before { @produit_nom.nom = 'a' * 101 }
    it { should_not be_valid }
  end

  describe "when nom is already taken" do
    before {
      produit_avec_meme_nom = @produit_nom.dup
      produit_avec_meme_nom.save
    }

    it { should_not be_valid }
  end

  describe "produits associations" do
    before { @produit_nom.save }

    let!(:produit1) do
      FactoryGirl.create(:produit, :produit_nom => @produit_nom)
    end

    let!(:produit2) do
      FactoryGirl.create(:produit, :produit_nom => @produit_nom)
    end

    it "should have 2 produits" do
      @produit_nom.produits.should == [produit1, produit2]
    end

  #   it "should destroy the associated produits" do
  #     produits = @produit_nom.produits.dup
  #     @produit_nom.destroy
  #     produits.should_not be_empty
  #     produits.each do |produit|
  #       Produit.find_by_id(produit.id).should be_nil
  #     end
  #   end
  end
end
