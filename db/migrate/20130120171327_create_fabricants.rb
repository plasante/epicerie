class CreateFabricants < ActiveRecord::Migration
  def change
    create_table :fabricants do |t|
      t.string :nom

      t.timestamps
    end
  end
end
