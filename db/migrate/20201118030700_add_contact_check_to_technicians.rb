class AddContactCheckToTechnicians < ActiveRecord::Migration[5.2]
  def change
    add_column :technicians, :contact_flag, :boolean
  end
end
