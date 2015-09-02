# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Catalog.destroy_all

10.times do |index|
  catalog = Catalog.create(name: "Catalog_#{index}", description: FFaker::Lorem.paragraph)

  (rand(10) + 1).times do |index|
    Product.create(name: "Product_#{index}", catalog_id: catalog.id, description: FFaker::Lorem.paragraph, price: (rand(99) + 100) / 100.0)
  end
end
