class AddContentToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :content, :string
    add_column :users, :time, :date
  end
end
