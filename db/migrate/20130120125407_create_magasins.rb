class CreateMagasins < ActiveRecord::Migration
  def change
    create_table :magasins do |t|
      t.string :nom
      t.string :description
      t.references :magasin_type

      t.timestamps
    end
    add_index :magasins, :magasin_type_id
  end
end
