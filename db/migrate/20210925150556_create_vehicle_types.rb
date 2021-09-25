class CreateVehicleTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :vehicle_types do |t|
      t.string :name
      t.string :watts
      t.string :battery_type

      t.timestamps
    end
  end
end
