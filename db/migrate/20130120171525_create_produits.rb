class CreateProduits < ActiveRecord::Migration
  def change
    create_table :produits do |t|
      t.references :produit_nom
      t.references :category
      t.references :fabricant
      t.references :format
      t.string :description

      t.timestamps
    end
    add_index :produits, :produit_nom_id
    add_index :produits, :category_id
    add_index :produits, :fabricant_id
    add_index :produits, :format_id
  end
end
