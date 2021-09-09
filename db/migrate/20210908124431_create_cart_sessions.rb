class CreateCartSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_sessions do |t|
      t.float :quantity
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
