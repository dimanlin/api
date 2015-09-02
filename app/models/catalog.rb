class Catalog < ActiveRecord::Base

  has_many :products, dependent: :destroy
  validates :name, :description, presence: true

end
