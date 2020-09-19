class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :line_id
      t.string :location
      t.string :tel
      t.boolean :privacy_flag
      t.boolean :location_flag
      t.integer :service_step

      t.timestamps
    end
  end
end
