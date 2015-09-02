FactoryGirl.define do
  sequence :catalog_name do |n|
    "catalog_#{n}"
  end

  factory :catalog do
    name { FactoryGirl.generate(:catalog_name) }
    description 'description'
  end
end