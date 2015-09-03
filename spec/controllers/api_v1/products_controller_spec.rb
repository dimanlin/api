require 'rails_helper'

RSpec.describe ApiV1::ProductsController, type: :controller do
  describe '.index' do
    before do
      @catalog = FactoryGirl.create(:catalog)
      @product_1 = FactoryGirl.create(:product, catalog_id: @catalog.id)
      @product_2 = FactoryGirl.create(:product, catalog_id: @catalog.id)
      get :index, format: :json, catalog_id: @catalog.id
    end

    it 'get categories' do
      expect(JSON.parse(response.body).size).to eq(2)

      expect(JSON.parse(response.body).first['name']).to eq(@product_1.name)
      expect(JSON.parse(response.body).first['description']).to eq(@product_1.description)
      expect(JSON.parse(response.body).first['price']).to eq(@product_1.price.to_s)

      expect(JSON.parse(response.body).last['name']).to eq(@product_2.name)
      expect(JSON.parse(response.body).last['description']).to eq(@product_2.description)
      expect(JSON.parse(response.body).last['price']).to eq(@product_2.price.to_s)
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
      expect(JSON.parse(response.body)['name']).to eq(@product.name)
      expect(JSON.parse(response.body)['description']).to eq(@product.description)
      expect(JSON.parse(response.body)['price']).to eq(@product.price.to_s)
      expect(JSON.parse(response.body)['catalog_id']).to eq(@catalog_id)
      expect(JSON.parse(response.body)['errors']).to eq({})
    end
  end

  describe '.update' do
    context 'invalid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
        post :update, catalog_id: @catalog.id, id: @product.id, format: :json, product: {name: ''}
      end

      it 'validation error' do
        expect(JSON.parse(response.body)['name']).to eq('')
        expect(JSON.parse(response.body)['description']).to eq(@product.description)
        expect(JSON.parse(response.body)['price']).to eq(@product.price.to_s)
        expect(JSON.parse(response.body)['catalog_id']).to eq(@catalog_id)
        expect(JSON.parse(response.body)['errors']).to eq({"name"=>["can't be blank"]})
      end
    end

    context 'valid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
        post :update, catalog_id: @catalog.id, id: @product.id, format: :json, product: {name: 'new_name'}
      end

      it 'update product name' do
        expect(JSON.parse(response.body)['name']).to eq('new_name')
        expect(JSON.parse(response.body)['description']).to eq(@product.description)
        expect(JSON.parse(response.body)['price']).to eq(@product.price.to_s)
        expect(JSON.parse(response.body)['catalog_id']).to eq(@catalog_id)
        expect(JSON.parse(response.body)['errors']).to eq({})
      end
    end
  end

  describe '.create' do
    context 'invalid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
        post :create, format: :json, catalog_id: @catalog.id, product: {name: '', description: ''}
      end

      it 'get validation errors' do
        expect(JSON.parse(response.body)['name']).to eq('')
        expect(JSON.parse(response.body)['description']).to eq('')
        expect(JSON.parse(response.body)['price']).to be nil
        expect(JSON.parse(response.body)['catalog_id']).to eq(@catalog_id)
        expect(JSON.parse(response.body)['errors']).to eq({"name"=>["can't be blank"], "description"=>["can't be blank"], "price"=>["can't be blank"]})
      end
    end

    context 'valid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        @product = FactoryGirl.create(:product, catalog_id: @catalog.id)
        post :create, catalog_id: @catalog.id, format: :json, product: {name: 'new_name', description: 'new_description', price: '100.44'}
      end

      it 'created new product' do
        expect(JSON.parse(response.body)['name']).to eq('new_name')
        expect(JSON.parse(response.body)['description']).to eq('new_description')
        expect(JSON.parse(response.body)['price']).to eq('100.44')
        expect(JSON.parse(response.body)['errors']).to eq({})
      end
    end
  end

end