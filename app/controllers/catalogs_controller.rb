class CatalogsController < ApplicationController

  before_action :init_catalog, only: [:show, :edit, :destroy, :update]

  def index
    @catalogs = Catalog.all
  end

  def edit
  end

  def show
  end

  def destroy
    @catalog.destroy
    redirect_to catalogs_path, notice: "Success"
  end

  def update
    if @catalog.update_attributes(catalog_params)
      redirect_to catalogs_path, notice: 'Success'
    else
      render :edit
    end
  end

  def new
    @catalog = Catalog.new
  end

  def create
    @catalog = Catalog.new(catalog_params)
    if @catalog.save
      redirect_to catalogs_path, notice: 'Success'
    else
      render :new
    end
  end


  private

  def init_catalog
    @catalog = Catalog.find(params[:id])
  end

  def catalog_params
    params.require(:catalog).permit(:name, :description)
  end
end
