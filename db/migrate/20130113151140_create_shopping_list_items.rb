class CreateShoppingListItems < ActiveRecord::Migration
  def change
    create_table :shopping_list_items do |t|
      t.references :shopping_list

      t.timestamps
    end
    add_index :shopping_list_items, :shopping_list_id
  end
end
