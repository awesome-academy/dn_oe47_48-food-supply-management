puts "Start create!"
5.times do
  name = Faker::Address.city
  District.create!(name: name)
end

i = 1
while i<6
  10.times do |n|
    name = Faker::Address.city
    district_id = i
    Town.create!(name: name, district_id: district_id)
  end
  i+=1
end

User.create!(
  full_name: "Hoang Nhan",
  email: "tranhuyhoangvct@gmail.com",
  phone: "0961162634",
  street: Faker::Address.street_address,
  password: "123123123",
  password_confirmation: "123123123",
  role: "admin",
  town_id: 1
)

50.times do |n|
  full_name = Faker::Name.name
  email = "email#{n}@gmail.com"
  phone = Faker::Number.number(digits: 10)
  street = Faker::Address.street_address
  password = "123123123"
  password_confirmation = "123123123"
  role = "buyer"
  town_id = 2

  User.create!(
    full_name: full_name, email: email,
    phone: phone,
    street: street,
    password: password,
    password_confirmation: password,
    role: role,
    town_id: town_id
  )
end
5.times do |n|
  name = "Category#{n+1}"
  Category.create!(name: name)
end

categories = Category.order(:created_at).take(5)
5.times do |n|
  name = "Category#{n+1}"
  categories.each do |categories |
    file_name = "product#{n+1}.jpg"
    categories.products.create!(name: name, description:"descri s"*50, price: 600, quantity: 9 )
    categories.products.each do |product|
      product.image.attach(io: File.open(Rails.root.join("app/assets/images/product/#{file_name}")), filename: file_name)
    end
  end
end

buyers = User.buyer.take(20)
buyers.each do |buyer|
  buyer.orders.create!(note: "none")
  buyer.orders.create!(note: "none2")
  buyer.orders.each do |order|
    total = 0
    order.order_products.create!(product_id: 1, quantity: 2, product_name: Product.find(1).name, price: Product.find(1).price)
    order.order_products.create!(product_id: 2, quantity: 1, product_name: Product.find(2).name, price: Product.find(1).price)
    order.order_products.each do |order_product|
      total += order_product.quantity * order_product.product_price
    end
    order.update!(total: total)
  end
end


puts "Completed!"
