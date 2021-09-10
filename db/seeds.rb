5.times do |n|
  name = "Category#{n+1}"
  Category.create!(name: name)
end

categorys = Category.order(:created_at).take(5)
5.times do |n|
  name = "Catego#{n+1}"
  categorys.each {|categorys |  categorys.products.create!(name: name, description:"descri s"*50, price: 600, quantity: 9 )}
end
