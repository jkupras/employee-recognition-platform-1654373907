class AddNumberOfAvailablePointsToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :available_points, :decimal, null: false, default: 0, precision: 8, scale: 2
  end
end
