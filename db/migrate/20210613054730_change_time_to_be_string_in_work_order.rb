class ChangeTimeToBeStringInWorkOrder < ActiveRecord::Migration[6.1]
  def up
    change_column :work_orders, :time, :string
  end

  def down
    change_column :work_orders, :time, :time
  end
end
