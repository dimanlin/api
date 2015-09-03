require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '.show' do
    before do
      @catalog = FactoryGirl.create(:catalog)
      @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
      get :show, catalog_id: @catalog.id, id: @product.id
    end

    it 'success' do
      expect(response).to be_success
    end
  end

  describe '.edit' do
    before do
      @catalog = FactoryGirl.create(:catalog)
      @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
      get :edit, catalog_id: @catalog.id, id: @product.id
    end

    it 'success' do
      expect(response).to be_success
    end
  end

  describe '.new' do
    before do
      @catalog = FactoryGirl.create(:catalog)
      get :new, catalog_id: @catalog.id
    end

    it 'success' do
      expect(response).to be_success
      expect(assigns[:catalog]).to eq(@catalog)
      expect(assigns[:product].new_record?).to be true
    end
  end

  describe '.index' do
    before do
      @catalog = FactoryGirl.create(:catalog)
      @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
      get :index, catalog_id: @catalog.id
    end

    it 'get categories' do
      expect(assigns[:catalog]).to eq(@catalog)
    end
  end

  describe '.destroy' do
    before do
      @catalog = FactoryGirl.create(:catalog)
      @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
    end

    it 'destroy product' do
      expect do
        post :destroy, catalog_id: @catalog.id, id: @product.id, format: :json
      end.to change{Product.count}.from(1).to(0)
      expect redirect_to catalog_products_path(catalog_id: @catalog.id)
    end
  end

  describe '.update' do
    context 'invalid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
        post :update, catalog_id: @catalog.id, id: @product.id, product: {name: ''}
      end

      it 'validation error for catalog name' do
        expect redirect_to catalog_products_path(catalog_id: @catalog.id)
      end
    end

    context 'valid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
        post :update, catalog_id: @catalog.id, id: @product.id, product: {name: 'new_name'}
      end

      it 'update catalog name' do
        expect render_template :edit
      end
    end
  end

  describe '.create' do
    context 'invalid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
        post :create, catalog_id: @catalog.id, product: {name: '', description: ''}
      end

      it 'get validation errors' do
        expect render_template :new
      end
    end

    context 'valid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
        post :create, catalog_id: @catalog.id, product: {name: 'new_name', description: 'new_description', price: '100.44'}
      end

      it 'created new catalog' do
        expect redirect_to catalog_products_path(catalog_id: @catalog.id)
      end
    end
  end

  describe 'private methods' do
    describe '.init_product' do
      let(:catalog) { FactoryGirl.create(:catalog) }
      let(:product) { FactoryGirl.create(:product, catalog_id: catalog.id) }
      before do
        expect(controller).to receive(:params).and_return({id: product.id})
      end

      it 'create instance variable @catalog' do
        expect do
          controller.send(:init_product)
        end.to change{controller.instance_variable_get(:@product)}.from(nil).to(product)
      end
    end
  end

end