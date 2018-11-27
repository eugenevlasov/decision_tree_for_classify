# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActionsController, type: :controller do
  describe 'GET index' do
    it 'response list of action' do
      act = Action.create(class_id: 10, properties: { a: 'b' })
      get :index, format: :json
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json).to be
      expect(json['actions'].size).to eq(1)
      srv_act = json['actions'].first
      expect(act[:class_id] == srv_act['class_id']).to be
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
    context 'success' do
      it 'with correct params' do
        act = { id: 10, properties: { a: 'b' } }
        post :create, params: act
        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json).to be
        srv_act = json
        expect(act[:id] == srv_act['class_id']).to be
      end
    end
  end
  describe 'destroy action' do
    context 'fail' do
      it 'without id' do
        Action.create(class_id: 10, properties: { a: 'b' })
        delete :destroy, params: { id: 10 }
        expect(response).to have_http_status(200)
      end
    end
  end
end
