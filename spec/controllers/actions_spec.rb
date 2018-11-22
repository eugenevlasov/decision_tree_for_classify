# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActionsController, type: :controller do
  describe 'GET index' do
    it 'assigns @teams' do
      Action.create(class_id: 10, properties: { a: 'b' })
      get :index, format: :json
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index, format: :json
      expect(response).to have_http_status(200)
    end
  end
  describe 'create action' do
    context 'fail' do
      it 'with wrong param' do
        post :create, params: {}
        expect(response).to have_http_status(500)
      end
    end
  end
end
