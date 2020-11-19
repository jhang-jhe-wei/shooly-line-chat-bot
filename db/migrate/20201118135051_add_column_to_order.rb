class AddColumnToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :name, :string
    add_column :orders, :time, :dateTime
    add_reference :orders, :Technician, foreign_key: true
    add_column :orders, :phone, :string
  end
end
