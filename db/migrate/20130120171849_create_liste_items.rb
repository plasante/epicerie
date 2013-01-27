class CreateListeItems < ActiveRecord::Migration
  def change
    create_table :liste_items do |t|
      t.references :user
      t.references :produit
      t.integer :qty, :default => 1

      t.timestamps
    end
    add_index :liste_items, :user_id
    add_index :liste_items, :produit_id
    add_index :liste_items, [:user_id, :produit_id], :unique => true
  end
end
