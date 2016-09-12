# docs: https://support.google.com/merchants/answer/188494?hl=en
google_merchant_brand      = variant.product.taxons.find {|x| x.taxonomy.name == "Brand" }
google_product_category    = variant.product.taxons.find {|x| x.taxonomy.name == "Google Category" }
google_product_type        = variant.product.taxons.find { |x| x.taxonomy.name == "Categories" }

shipping_category          = variant.product.shipping_category.name
shipping_price             = "0.0 EUR"

case shipping_category
  when "Default"
    shipping_price = "4.0 EUR"
  when "Accessories"
    shipping_price = "8.9 EUR"
end

xml.tag! "g:id", variant.product.id
xml.tag! "g:title", variant.product.name
xml.tag! "g:description", variant.product.description
xml.tag! "g:link", @production_domain + 'products/' + variant.product.slug
xml.tag! "g:image_link", variant.product.images.first.attachment.url(:product) unless variant.product.images.empty?
xml.tag! "g:price", variant.price.to_s + ' EUR'
xml.tag! "g:condition", variant.product.property("Condition")
xml.tag! "g:availability", Spree::Stock::Quantifier.new(variant).total_on_hand > 0 ? 'in stock' : 'out of stock'
xml.tag! "g:gtin", variant.product.property("GTIN")
xml.tag! "g:brand", google_merchant_brand.name if google_merchant_brand

xml.g:shipping do
  xml.tag! "g:price", shipping_price
end

xml.tag! "g:google_product_category", google_product_category.name if google_product_category
xml.tag! "g:product_type", google_product_type.name if google_product_type
