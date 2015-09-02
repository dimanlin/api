class ApiV1::CatalogsController < ApplicationController

  before_action :init_catalog, only: [:destroy, :update]
  layout :false

  def index
    @catalogs = Catalog.all
  end

  def destroy
    @catalog.destroy
  end

  def update
    @catalog.update_attributes(catalog_params)
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
