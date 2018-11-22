# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Action, type: :model do
  context 'creation' do
    it 'fail on class_id null value' do
      act = Action.new(properties: { a: 'b' })
      expect(act.valid?).to be_falsey
    end
    it 'fail on properties null value' do
      act = Action.new(class_id: 1)
      expect(act.valid?).to be_falsey
    end
  end
end
