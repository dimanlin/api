class Product < ActiveRecord::Base
  belongs_to :catalog

  validates :name, :description, :price, :catalog_id, presence: true
  
end
