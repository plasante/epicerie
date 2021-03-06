require 'spec_helper'

describe Produit do

  let!(:produit_nom) { FactoryGirl.create(:produit_nom, :nom => 'Lait ecreme') }
  let!(:category) { FactoryGirl.create(:category, :nom => 'Produits Laitiers') }
  let!(:fabricant) { FactoryGirl.create(:fabricant, :nom => 'Quebon') }
  let!(:format) { FactoryGirl.create(:format, :nom => '2L') }

  before {
    @produit = Produit.new(:produit_nom => produit_nom,
                           :category => category,
                           :fabricant => fabricant,
                           :format => format,
                           :description => 'description')
  }
  
  subject { @produit }

  it { should be_valid }

  describe "attributes" do
    it { should respond_to(:produit_nom) }
    it { should respond_to(:category) }
    it { should respond_to(:fabricant) }
    it { should respond_to(:format) }
    it { should respond_to(:description) }
  end

  describe "methods" do
  end

  describe "validation" do
    describe "when description is too long" do
      before { @produit.description = 'a' * 256 }
      it { should_not be_valid }
    end
  end

  describe "associations" do
    its(:produit_nom) { should == produit_nom }
    its(:category) { should == category }
    its(:fabricant) { should == fabricant }
    its(:format) { should == format }
  end
end
