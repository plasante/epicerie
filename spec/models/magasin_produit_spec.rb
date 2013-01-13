# == Schema Information
#
# Table name: magasin_produits
#
#  id            :integer          not null, primary key
#  magasin_id    :integer
#  produit_id    :integer
#  quantity      :integer          default(1)
#  prix_regulier :decimal(12, 2)   default(0.0)
#  prix_special  :decimal(12, 2)   default(0.0)
#  date_debut    :date
#  date_fin      :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'spec_helper'

describe MagasinProduit do
  
end
