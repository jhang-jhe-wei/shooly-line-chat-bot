class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :technician, foreign_key: true
      t.string :content
      t.string :location

      t.timestamps
    end
  end
end
