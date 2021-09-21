module ProductsHelper
  def product_image product
    if product.image.attached?
      image_tag product.image, class: "image_size"
    else
      image_tag "product/default_image.jpg", class: "image_size"\
    end
  end
end
