class CreateBatteries < ActiveRecord::Migration[5.0]
  def change
    create_table :batteries do |t|
      t.string :name
      t.string :capacity

      t.timestamps
    end
  end
end
