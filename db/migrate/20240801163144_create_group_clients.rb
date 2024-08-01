class CreateGroupClients < ActiveRecord::Migration[7.1]
  def change
    create_table :group_clients do |t|
      t.references :group, foreign_key: true
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
