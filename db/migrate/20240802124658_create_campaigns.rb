class CreateCampaigns < ActiveRecord::Migration[7.1]
  def change
    create_table :campaigns do |t|
      t.references :group, foreign_key: true
      t.string :name
      t.text :body
      t.datetime :send_at
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
