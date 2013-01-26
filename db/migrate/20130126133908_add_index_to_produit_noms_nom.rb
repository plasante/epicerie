class AddIndexToProduitNomsNom < ActiveRecord::Migration
  def change
  	add_index :produit_noms, :nom, :unique => true
  	add_index :categories, :nom, :unique => true
  	add_index :fabricants, :nom, :unique => true
  	add_index :formats, :nom, :unique => true
  end
end
