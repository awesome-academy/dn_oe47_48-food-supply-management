class Product < ApplicationRecord
  belongs_to :category
  has_many :order_prodcuts, dependent: :destroy
  has_many :cart_details, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true, numericality: {only_integer: false}
  validates :quantity, presence: true, numericality: {only_integer: false}
  validates :description, presence: true,
    length: {minimum: Settings.product.min_description}
  validates :image,
            content_type: {
              in: Settings.product.image_type,
              message: :image_invalid_type
            },
            size: {
              less_than: Settings.product.image_size.megabytes,
              message: :image_invalid_size
            }
  scope :search_categories, (lambda do |key|
    joins(:category)
    .where("categories.name LIKE ?", "%#{key}%")
  end)
  scope :search_products, ->(key){where "products.name LIKE ?", "%#{key}%"}
  scope :load_by_ids, ->(ids){where id: ids}

  def handle_update_quantity quantity_order
    update_attribute :quantity, quantity - quantity_order
  end
end
