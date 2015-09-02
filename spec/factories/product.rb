FactoryGirl.define do
  sequence :product_name do |n|
    "product_#{n}"
  end

  factory :product do
    name { FactoryGirl.generate(:product_name) }
    price 100.00
    description 'description'
  end
end