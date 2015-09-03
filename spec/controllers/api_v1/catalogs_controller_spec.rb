require 'rails_helper'

RSpec.describe ApiV1::CatalogsController, type: :controller do
  describe '.index' do
    before do
      @catalog_1 = FactoryGirl.create(:catalog)
      @catalog_2 = FactoryGirl.create(:catalog)
      get :index, format: :json
    end

    it 'get categories' do
      expect(JSON.parse(response.body).size).to eq(2)
      expect(JSON.parse(response.body).first['name']).to eq(@catalog_1.name)
      expect(JSON.parse(response.body).last['name']).to eq(@catalog_2.name)
    end
  end

  describe '.destroy' do
    before do
      @catalog = FactoryGirl.create(:catalog)
    end

    context 'success' do
      it 'destroy catalog' do
        expect do
          post :destroy, id: @catalog.id, format: :json
        end.to change{Catalog.count}.from(1).to(0)

        expect(JSON.parse(response.body)['name']).to eq(@catalog.name)
        expect(JSON.parse(response.body)['description']).to eq(@catalog.description)
        expect(JSON.parse(response.body)['created_at'].present?).to be true
        expect(JSON.parse(response.body)['updated_at'].present?).to be true
        expect(JSON.parse(response.body)['errors']).to be nil
      end
    end
  end

  describe '.update' do
    context 'invalid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        post :update, id: @catalog.id, format: :json, catalog: {name: ''}
      end

      it 'validation error for catalog name' do
        expect(JSON.parse(response.body)['name']).to eq('')
        expect(JSON.parse(response.body)['errors']).to eq({"name"=>["can't be blank"]})
      end
    end

    context 'valid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        post :update, id: @catalog.id, format: :json, catalog: {name: 'new_name'}
      end

      it 'update name of catalog' do
        expect(JSON.parse(response.body)['name']).to eq('new_name')
        expect(JSON.parse(response.body)['errors']).to eq({})
      end
    end
  end

  describe '.create' do
    context 'invalid' do
      before do
        post :create, format: :json, catalog: {name: '', description: ''}
      end

      it 'get validation errors' do
        expect(JSON.parse(response.body)['name']).to eq('')
        expect(JSON.parse(response.body)['description']).to eq('')
        expect(JSON.parse(response.body)['errors']).to eq({"name"=>["can't be blank"], "description"=>["can't be blank"]})
      end
    end

    context 'valid' do
      before do
        post :create, format: :json, catalog: {name: 'new_name', description: 'new_description'}
      end

      it 'create new catalog' do
        expect(JSON.parse(response.body)['name']).to eq('new_name')
        expect(JSON.parse(response.body)['description']).to eq('new_description')
        expect(JSON.parse(response.body)['errors']).to eq({})
      end
    end
  end
end