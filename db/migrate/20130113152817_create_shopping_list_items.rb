class CreateShoppingListItems < ActiveRecord::Migration
  def change
    create_table :shopping_list_items do |t|
      t.references :shopping_list
      t.references :magasin_produit

      t.timestamps
    end
    add_index :shopping_list_items, :shopping_list_id
    add_index :shopping_list_items, :magasin_produit_id
  end
end
