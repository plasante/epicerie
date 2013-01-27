require 'spec_helper'

describe ListeItem do
  let!(:produit_nom) { FactoryGirl.create(:produit_nom, :nom => 'Lait ecreme') }
  let!(:category) { FactoryGirl.create(:category, :nom => 'Produits Laitiers') }
  let!(:fabricant) { FactoryGirl.create(:fabricant, :nom => 'Quebon') }
  let!(:format) { FactoryGirl.create(:format, :nom => '2L') }

  let!(:produit) { FactoryGirl.create(:produit,
  									  :produit_nom => produit_nom,
  									  :category => category,
  									  :fabricant => fabricant,
  									  :format => format) }

  let!(:user) { FactoryGirl.create(:user) }

  before {
  	@liste_item = ListeItem.new(:user => user,
  								:produit => produit,
  								:qty => 1)
  }

  subject { @liste_item }

  it { should be_valid }

  describe "attributes" do
  	it { should respond_to(:qty) }
  end

  describe "methods" do
  	it { should respond_to(:user) }
  	it { should respond_to(:produit) }
  end

  describe "validations" do
  	describe "when user is nil" do
  	  before { @liste_item.user = nil }
  	  it { should_not be_valid }
  	end
  	describe "when produit is nil" do
  	  before { @liste_item.produit = nil }
  	  it { should_not be_valid }
  	end
  	describe "for qty" do
  	  describe "when not a number" do
  	  	before { @liste_item.qty = 'a' }
  	  	it { should_not be_valid }
  	  end
  	end
  end

  describe "associations" do
  	describe "with users" do
  	  it "username" do
  	  	@liste_item.user.username.should == user.username
  	  end
  	end
  	describe "with produits" do
  	  it "produit_nom.nom" do
  	  	@liste_item.produit.produit_nom.nom.should == produit_nom.nom
  	  end
  	  it "category.nom" do
  	  	@liste_item.produit.category.nom.should == category.nom
  	  end
  	  it "fabricant.nom" do
  	  	@liste_item.produit.fabricant.nom.should == fabricant.nom
  	  end
  	  it "format.nom" do
  	  	@liste_item.produit.format.nom.should == format.nom
  	  end
  	end
  end
end
