class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :quantity, :price, to: :product, prefix: true
  validates :quantity, presence: true
end
