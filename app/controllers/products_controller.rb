class ProductsController < ApplicationController
  before_action :init_product, only: [:show, :edit, :update]

  def index
    @catalog = Catalog.find(params[:catalog_id])
    @products = @catalog.products
  end

  def show
  end

  def edit
  end

  def update
    if @product.update_attributes(product_params)
      redirect_to catalog_products_path(catalog_id: @product.catalog.id), notes: 'Success'
    else
      render :edit
    end
  end

  private

  def init_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :catalog_id)
  end

end
