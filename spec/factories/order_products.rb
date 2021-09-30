FactoryBot.define do
  factory :order_product do
    order_id {create(:order).id}
    product_id {create(:product).id}
    quantity {2}
    product_name {Product.find(product_id).name}
    price {Product.find(product_id).price}
  end
end
