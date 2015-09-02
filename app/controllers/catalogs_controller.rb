class CatalogsController < ApplicationController

  before_action :init_catalog, only: [:show, :edit]

  def index
    @catalogs = Catalog.all
  end

  def show
  end

  def edit
  end

  def destroy
    @catalog.destroy
    redirect_to catalog_path, notice: "Success"
  end


  private

  def init_catalog
    @catalog = Catalog.find(params[:id])
  end
end
