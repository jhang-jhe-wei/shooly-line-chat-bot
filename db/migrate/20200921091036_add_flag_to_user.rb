class AddFlagToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name_flag, :string
    add_column :users, :phone_flag, :string
  end
end
