class AddTechnicianLineIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :technician_line_id, :string
  end
end
