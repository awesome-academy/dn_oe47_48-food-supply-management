class CreateOrderProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :order_products do |t|
      t.float :quantity
      t.float :price
      t.string :product_name
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false

      t.timestamps
    end
  end
end
