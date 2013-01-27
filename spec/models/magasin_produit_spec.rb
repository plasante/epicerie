require 'spec_helper'

describe MagasinProduit do
  let!(:magasin_type) { FactoryGirl.create(:magasin_type, :nom => 'epicerie') }

  let!(:produit_nom) { FactoryGirl.create(:produit_nom, :nom => 'Lait ecreme') }
  let!(:category) { FactoryGirl.create(:category, :nom => 'Produits Laitiers') }
  let!(:fabricant) { FactoryGirl.create(:fabricant, :nom => 'Quebon') }
  let!(:format) { FactoryGirl.create(:format, :nom => '2L') }

  let!(:magasin) { FactoryGirl.create(:magasin, 
  									  :nom => 'IGA', 
  									  :magasin_type => magasin_type) }
  
  let!(:produit) { FactoryGirl.create(:produit,
  									  :produit_nom => produit_nom,
  									  :category => category,
  									  :fabricant => fabricant,
  									  :format => format) }
  before {
  	@magasin_produit = MagasinProduit.new(:magasin => magasin,
  										  :produit => produit,
  										  :prix_regulier => 2.22,
  										  :prix_special => 1.11,
  										  :date_debut => '2013-02-01',
  										  :date_fin => '2013-02-07')
  }

  subject { @magasin_produit }

  it { should be_valid }

  describe "attributes or methods" do
    it { should respond_to(:magasin) }
    it { should respond_to(:produit) }
    it { should respond_to(:prix_regulier) }
    it { should respond_to(:prix_special) }
    it { should respond_to(:date_debut) }
    it { should respond_to(:date_fin) }
  end

  describe "validation" do
  	describe "when magasin is nil" do
  	  before { @magasin_produit.magasin = nil }
  	  it { should_not be_valid }
  	end
  	describe "when produit is nil" do
  	  before { @magasin_produit.produit = nil }
  	  it { should_not be_valid }
  	end
  	describe "when prix_regulier is not a number" do
  	  before { @magasin_produit.prix_regulier = 'a' }
  	  it { should_not be_valid }
  	end
  	describe "when  prix_special is not a number" do
  	  before { @magasin_produit.prix_special = 'a' }
  	  it { should_not be_valid }
  	end
  end

  describe "associations" do
  	it "to magasin.nom" do
  	  @magasin_produit.magasin.nom.should == magasin.nom
  	end
  	it "to magasin.magasin_type.nom" do
  	  @magasin_produit.magasin.magasin_type.nom.should == magasin_type.nom
  	end
  	it "to produit.produit.description" do
  	  @magasin_produit.produit.description.should == produit.description
  	end
  	it "to produit.produit_nom.nom" do
  	  @magasin_produit.produit.produit_nom.nom.should == produit_nom.nom
  	end
  	it "to produit.category.nom" do
  	  @magasin_produit.produit.category.nom.should == category.nom
  	end
  	it "to produit.fabricant.nom" do
  	  @magasin_produit.produit.fabricant.nom.should == fabricant.nom
  	end
  	it "to produit.format.nom" do
  	  @magasin_produit.produit.format.nom.should == format.nom
  	end
  end
end
