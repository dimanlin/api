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

  def create
    @catalog = Catalog.new(catalog_params)
    @catalog.save
  end


  private

  def init_catalog
    @catalog = Catalog.find(params[:id])
  end

  def catalog_params
    params.require(:catalog).permit(:name, :description)
  end
end
