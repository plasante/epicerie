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
end
