class CreateCampaigns < ActiveRecord::Migration[7.1]
  def change
    create_table :campaigns do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.string :subject
      t.text :body
      t.datetime :send_at
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
