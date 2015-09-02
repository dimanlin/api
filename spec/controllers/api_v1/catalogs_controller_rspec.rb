require 'rails_helper'

RSpec.describe ApiV1::CatalogsController, type: :controller do
  describe '.index' do
    before do
      @catalog = FactoryGirl.create(:catalog)
      get :index, format: :json
    end

    it 'get categories' do
      expect(JSON.parse(response.body)['catalogs'].size).to eq(1)
      expect(JSON.parse(response.body)['catalogs'].first['name']).to eq(@catalog.name)
      expect(JSON.parse(response.body)['catalogs'].first['description']).to eq(@catalog.description)
    end
  end

  describe '.destroy' do
    before do
      @catalog = FactoryGirl.create(:catalog)
    end

    it 'destroy category' do
      expect do
        post :destroy, id: @catalog.id, format: :json
      end.to change{Catalog.count}.from(1).to(0)
      expect(JSON.parse(response.body)['catalog']['name']).to eq(@catalog.name)
      expect(JSON.parse(response.body)['catalog']['description']).to eq(@catalog.description)
    end
  end

  describe '.update' do
    context 'invalid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        post :update, id: @catalog.id, format: :json, catalog: {name: ''}
      end

      it 'destroy category' do
        expect(JSON.parse(response.body)['catalog']['name']).to eq('')
        expect(JSON.parse(response.body)['catalog']['errors']).to eq({"name"=>["can't be blank"]})
      end
    end

    context 'valid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        post :update, id: @catalog.id, format: :json, catalog: {name: 'new_name'}
      end

      it 'destroy category' do
        expect(JSON.parse(response.body)['catalog']['name']).to eq('new_name')
        expect(JSON.parse(response.body)['catalog']['errors']).to eq({})
      end
    end
  end

  describe '.create' do
    context 'invalid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        post :create, format: :json, catalog: {name: '', description: ''}
      end

      it 'get validation errors' do
        expect(JSON.parse(response.body)['catalog']['name']).to eq('')
        expect(JSON.parse(response.body)['catalog']['description']).to eq('')
        expect(JSON.parse(response.body)['catalog']['errors']).to eq({"name"=>["can't be blank"], "description"=>["can't be blank"]})
      end
    end

    context 'valid' do
      before do
        @catalog = FactoryGirl.create(:catalog)
        post :create, id: @catalog.id, format: :json, catalog: {name: 'new_name', description: 'new_description'}
      end

      it 'destroy category' do
        expect(JSON.parse(response.body)['catalog']['name']).to eq('new_name')
        expect(JSON.parse(response.body)['catalog']['description']).to eq('new_description')
        expect(JSON.parse(response.body)['catalog']['errors']).to eq({})
      end
    end
  end
end