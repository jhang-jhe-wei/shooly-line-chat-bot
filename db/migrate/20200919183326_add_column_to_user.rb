class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :location1, :string
    add_column :users, :location2, :string
    add_column :users, :location3, :string
  end
end
