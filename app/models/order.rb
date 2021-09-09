class Order < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :order_product, dependent: :destroy

  validates :total, presence: true
  validates :data, presence: true
end
