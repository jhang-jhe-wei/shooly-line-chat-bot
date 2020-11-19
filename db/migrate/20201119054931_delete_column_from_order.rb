class DeleteColumnFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :technician_id
  end
end
