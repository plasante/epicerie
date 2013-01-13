class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.references :user

      t.timestamps
    end
    add_index :shopping_lists, :user_id
  end
end
