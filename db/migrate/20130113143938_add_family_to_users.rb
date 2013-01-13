class AddFamilyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :family, :boolean
  end
end
