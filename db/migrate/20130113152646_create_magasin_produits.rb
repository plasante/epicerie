class CreateMagasinProduits < ActiveRecord::Migration
  def change
    create_table :magasin_produits do |t|
      t.references :magasin
      t.references :produit
      t.integer :quantity, :default => 1
      t.decimal :prix_regulier, :precision => 12, :scale => 2, :default => 0
      t.decimal :prix_special, :precision => 12, :scale => 2, :default => 0
      t.date :date_debut
      t.date :date_fin

      t.timestamps
    end
    add_index :magasin_produits, :magasin_id
    add_index :magasin_produits, :produit_id
  end
end
