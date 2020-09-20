class ChangeDatetimeUser < ActiveRecord::Migration[5.2]
  def change
    change_column(:users, :time, :datetime)
  end
end
