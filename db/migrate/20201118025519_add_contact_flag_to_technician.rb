class AddContactFlagToTechnician < ActiveRecord::Migration[5.2]
  def change
    add_column :technicians, :contact_id, :string
  end
end
