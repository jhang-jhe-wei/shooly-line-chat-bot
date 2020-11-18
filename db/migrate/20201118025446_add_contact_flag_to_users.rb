class AddContactFlagToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :contact_id, :string
  end
end
