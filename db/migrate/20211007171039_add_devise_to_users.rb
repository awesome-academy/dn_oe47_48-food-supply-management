# frozen_string_literal: true

class AddDeviseToUsers < ActiveRecord::Migration[6.1]
  def self.up
    change_table :users do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      t.datetime :remember_created_at
    end

  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end

end
