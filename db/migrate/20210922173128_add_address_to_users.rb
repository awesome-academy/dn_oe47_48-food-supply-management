class AddAddressToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :address, :string
  end
end
