class AddIndexForProductCategoryId < ActiveRecord::Migration
  def change
    add_index :products, :catalog_id
  end
end
