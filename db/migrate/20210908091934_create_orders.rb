class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :status, null: false, default: 0
      t.string :note
      t.float :total
      t.string :data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
