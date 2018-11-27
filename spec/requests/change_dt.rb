# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Approachs', type: :request do
  before do
    acts = []
    acts << { class_id: 11, properties: { color: 'green', location: 'unknown' } }

    acts << { class_id: 12, properties: { color: 'red', real: 'no' } }
    acts << { class_id: 13, properties: { location: 'moscow' } }
    acts.each do |a|
      Action.create(a)
    end
    Decision::Tree.make(ConvertActions.call(Action.all))
  end
  context 'change dt after ' do
    it 'create action' do
      post actions_path, params: { id: 14, properties: { dummy: 'no' } }
      expect(response).to have_http_status(200)
      get classify_path, params: { obj: { dummy: 'no', smart: 'yes' } }

      expect(response).to have_http_status(200)
      res = JSON.parse(response.body)
      expect(res['class_id']).to eq(14)
    end
    it 'destroy action' do
      delete action_path(id: 13)
      expect(response).to have_http_status(200)
      get classify_path, params: { obj: { location: 'moscow' } }

      expect(response).to have_http_status(200)
      res = JSON.parse(response.body)
      expect(res['class_id'].empty?).to be
    end
  end
end
