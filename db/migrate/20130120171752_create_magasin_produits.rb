class CreateMagasinProduits < ActiveRecord::Migration
  def change
    create_table :magasin_produits do |t|
      t.references :magasin
      t.references :produit
      t.decimal :prix_regulier, :precision => 12, :scale => 2
      t.decimal :prix_special, :precision => 12, :scale => 2
      t.date :date_debut, :default => Date.today
      t.date :date_fin, :default => Date.today

      t.timestamps
    end
    add_index :magasin_produits, :magasin_id
    add_index :magasin_produits, :produit_id
  end
end
