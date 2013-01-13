# == Schema Information
#
# Table name: magasin_types
#
#  id         :integer          not null, primary key
#  nom        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe MagasinType do
	before { @magasin_type = MagasinType.new( :nom => 'magasin') }

	subject { @magasin_type }

	it { should respond_to(:magasins) }
end
