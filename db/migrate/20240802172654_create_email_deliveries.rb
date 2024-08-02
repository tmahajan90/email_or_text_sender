class CreateEmailDeliveries < ActiveRecord::Migration[7.1]
  def change
    create_table :email_deliveries do |t|
      t.references :campaign, foreign_key: true
      t.references :client, foreign_key: true
      t.string :status
      t.string :failure_reason

      t.timestamps
    end
  end
end
