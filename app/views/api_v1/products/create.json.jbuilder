json.product do
  json.partial! partial: 'product', locals: {product: @product}
end