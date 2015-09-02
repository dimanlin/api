class ProductsController < ApplicationController
  before_action :init_product, only: [:show, :edit, :update, :destroy]

  def new
    @catalog = Catalog.find(params[:catalog_id])
    @product = @catalog.products.new
  end

  def index
    @catalog = Catalog.find(params[:catalog_id])
    @products = @catalog.products
  end

  def show
  end

  def edit
    @catalog = Catalog.find(params[:catalog_id])
  end

  def update
    @catalog = Catalog.find(params[:catalog_id])
    if @product.update_attributes(product_params)
      redirect_to catalog_products_path(catalog_id: @product.catalog.id), notes: 'Success'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to catalog_products_path(catalog_id: @product.catalog.id), notice: 'Success'
  end

  def create
    @catalog = Catalog.find(params[:catalog_id])
    @product = @catalog.products.new(product_params)
    if @product.save
      redirect_to catalog_products_path(catalog_id: @catalog.id)
    else
      render :new
    end
  end

  private

  def init_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

end
