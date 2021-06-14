class ChangeDatetimeToBeTimeInWorkOrder < ActiveRecord::Migration[6.1]
  def up
    change_column :work_orders, :time, :time
  end

  def down
    change_column :work_orders, :time, :datetime
  end
end
