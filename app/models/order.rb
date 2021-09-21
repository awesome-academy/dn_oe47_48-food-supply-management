class Order < ApplicationRecord
  enum status: {processing: 0, shipped: 1, completed: 2, canceled: 3}

  belongs_to :user, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  delegate :full_name, :email, :phone, :street, :town, to: :user
  scope :order_by_status, ->{order :status}
end
