class CreateGroceriesLists < ActiveRecord::Migration
  def change
    create_table :groceries_lists do |t|
      t.references :user

      t.timestamps
    end
    add_index :groceries_lists, :user_id
  end
end
