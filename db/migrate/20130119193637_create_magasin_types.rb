class CreateMagasinTypes < ActiveRecord::Migration
  def change
    create_table :magasin_types do |t|
      t.enum :nom

      t.timestamps
    end
  end
end
