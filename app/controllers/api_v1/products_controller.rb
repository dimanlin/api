class ApiV1::ProductsController < ApplicationController
  before_action :init_product, only: [:show, :update, :destroy]
  layout :false

  def index
    catalog = Catalog.find(params[:catalog_id])
    @products = catalog.products
  end

  def show
  end

  def update
    @product.update_attributes(product_params)
  end

  def destroy
    @product.destroy
  end

  def create
    catalog = Catalog.find(params[:catalog_id])
    @product = catalog.products.new(product_params)
    @product.save
  end

  private

  def init_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
