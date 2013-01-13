# == Schema Information
#
# Table name: magasins
#
#  id              :integer          not null, primary key
#  nom             :string(255)
#  description     :text
#  magasin_type_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe Magasin do
	# creation d'un objet de la table mere
	let(:magasin_type) { FactoryGirl.create(:magasin_type) }

	before { @magasin = magasin_type.magasins.build( :nom => 'nom', :description => 'description') }

	subject { @magasin }

	it { should respond_to(:magasin_type_id) }

	it { should respond_to(:magasin_type) }
end
