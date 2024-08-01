class CreateClients < ActiveRecord::Migration[5.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :mobile_no
      t.boolean :undeliverable, default: false
      t.boolean :bounce_count
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
