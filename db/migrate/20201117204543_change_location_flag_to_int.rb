class ChangeLocationFlagToInt < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :location_flag, :integer, :using => 'case when location_flag then 1 else 2 end'
  end
end
