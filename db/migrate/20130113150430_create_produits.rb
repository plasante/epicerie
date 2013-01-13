class CreateProduits < ActiveRecord::Migration
  def change
    create_table :produits do |t|
      t.string :nom
      t.text :description
      t.references :category
      t.references :manufacturer

      t.timestamps
    end
    add_index :produits, :category_id
    add_index :produits, :manufacturer_id
  end
end
