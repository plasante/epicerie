# == Schema Information
#
# Table name: produits
#
#  id              :integer          not null, primary key
#  nom             :string(255)
#  description     :text
#  category_id     :integer
#  manufacturer_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Produit do
  let(:category) { FactoryGirl.create(:category) }
  let(:manufacturer) { FactoryGirl.create(:manufacturer) }

  before { @produit = category.produits.build( :nom => 'nom' , 
  											   :description => 'description',
  											   :manufacturer_id => manufacturer.id) }
  
  subject { @produit }

  it { should respond_to(:category) }
  it { should respond_to(:manufacturer) }

  its(:category) { should == category }
  its(:manufacturer) { should == manufacturer }

  it { should be_valid }

  describe "when category_id is not present" do
    before { @produit.category_id = nil }
    it { should_not be_valid }
  end

  describe "when manufacturer_id is not present" do
    before { @produit.manufacturer_id = nil }
    it { should_not be_valid }
  end

  describe "with blank nom" do
  	before { @produit.nom = " " }
    it { should_not be_valid }
  end

  describe "with nom that is too long" do
    before { @produit.nom = "a" * 141 }
    it { should_not be_valid }
  end

  describe "with blank description" do
  	before { @produit.description = " " }
    it { should_not be_valid }
  end

  describe "with nom that is too long" do
    before { @produit.description = "a" * 1001 }
    it { should_not be_valid }
  end
end
