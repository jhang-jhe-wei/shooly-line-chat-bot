class CreateTechnicians < ActiveRecord::Migration[5.2]
  def change
    create_table :technicians do |t|
      t.string :line_id
      t.string :name
      t.string :comment
      t.string :location
      t.string :time
      t.string :photo

      t.timestamps
    end
  end
end
