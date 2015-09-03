require 'rails_helper'

RSpec.describe CatalogsController, type: :controller do
  describe '.index' do
    before do
      @catalog_1 = FactoryGirl.create(:catalog)
      @catalog_2 = FactoryGirl.create(:catalog)
      get :index
    end

    it 'get categories' do
      expect(assigns[:catalogs]).to include(@catalog_1)
      expect(assigns[:catalogs]).to include(@catalog_2)
    end
  end

  describe '.destroy' do
    before do
      @catalog = FactoryGirl.create(:catalog)
    end

    it 'destroy catalog' do
      expect do
        post :destroy, id: @catalog.id
      end.to change{Catalog.count}.from(1).to(0)
      expect redirect_to catalogs_path
    end
  end

  describe '.update' do
    before do
      @catalog = FactoryGirl.create(:catalog)
    end

    context 'invalid' do
      before do
        post :update, id: @catalog.id, catalog: {name: ''}
      end

      it 'invalid catalog name' do
        expect render_template :edit
      end
    end

    context 'valid' do
      before do
        post :update, id: @catalog.id, catalog: {name: 'new_name'}
      end

      it 'update name of catalog' do
        expect redirect_to catalogs_path
      end
    end
  end

  describe '.create' do
    context 'invalid' do
      before do
        post :create, catalog: {name: '', description: ''}
      end

      it 'get validation errors' do
        expect render_template 'new'
      end
    end

    context 'valid' do
      before do
        post :create, catalog: {name: 'new_name', description: 'new_description'}
      end

      it 'redirect to ' do
        expect redirect_to catalogs_path
      end
    end
  end

  describe '.edit' do
    let(:catalog) { FactoryGirl.create(:catalog) }
    before do
      get :edit, id: catalog.id
    end

    it 'success' do
      expect(assigns[:catalog]).to eq(catalog)
    end
  end

  describe '.show' do
    let(:catalog) { FactoryGirl.create(:catalog) }
    before do
      get :show, id: catalog.id
    end

    it 'success' do
      expect(assigns[:catalog]).to eq(catalog)
    end
  end

  describe 'private methods' do
    describe '.init_catalog' do
      let(:catalog) { FactoryGirl.create(:catalog) }
      before do
        expect(controller).to receive(:params).and_return({id: catalog.id})
      end

      it 'create instance variable @catalog' do
        expect do
          controller.send(:init_catalog)
        end.to change{controller.instance_variable_get(:@catalog)}.from(nil).to(catalog)
      end
    end
  end
end