# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClassificatorController, type: :controller do
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
  describe 'GET classify' do
    it 'correct' do
      get :classify, params: { obj: { color: 'green',
                                      location: 'unknown',
                                      type: 'martian',
                                      weight: 'light' } }
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['class_id']).to eq(11)
    end
    it 'fail without obj' do
      get :classify
      expect(response).to have_http_status(500)
    end
  end
end
