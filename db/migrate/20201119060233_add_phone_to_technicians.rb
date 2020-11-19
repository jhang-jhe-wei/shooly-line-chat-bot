class AddPhoneToTechnicians < ActiveRecord::Migration[5.2]
  def change
    add_column :technicians, :phone, :string
  end
end
