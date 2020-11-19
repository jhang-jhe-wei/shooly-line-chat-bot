class AddTechnicianLineIdToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :technician_line_id, :string
  end
end
