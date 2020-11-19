class AddUserLineIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :user_line_id, :string
    add_column :orders, :state, :string
  end
end
