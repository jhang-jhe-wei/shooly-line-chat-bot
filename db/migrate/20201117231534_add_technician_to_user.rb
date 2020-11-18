class AddTechnicianToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :technician, foreign_key: true
  end
end
