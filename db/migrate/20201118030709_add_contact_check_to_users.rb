class AddContactCheckToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :contact_flag, :boolean
  end
end
