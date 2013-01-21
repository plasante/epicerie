class CreateProduitNoms < ActiveRecord::Migration
  def change
    create_table :produit_noms do |t|
      t.string :nom

      t.timestamps
    end
  end
end
