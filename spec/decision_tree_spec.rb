# frozen_string_literal: true

require 'decision_tree'

RSpec.describe DecisionTree do
  let (:exp) { DecisionTree::ClassesIncorrect }
  let (:dup_exp) { DecisionTree::DuplicatedClassId }
  let (:actions) do
    acts = []
    acts << { id: 11, properties: { color: 'green', location: 'unknown' } }

    acts << { id: 12, properties: { color: 'red', real: 'no' } }
    acts << { id: 13, properties: { location: 'moscow' } }
    acts
  end
  context 'create tree' do
    it 'from array' do
      tr = DecisionTree::Tree.new(actions)
      expect(tr).to be
    end
  end
  context 'classify' do
    it 'classify correctry' do
      tr = DecisionTree::Tree.new(actions)
      obj = { color: 'green', location: 'unknown', type: 'martian', weight: 'light' }
      class_id = tr.classify(obj)

      expect(class_id).to equal(11)

      obj = { real: 'no', type: 'cat', name: 'Murka' }
      class_id = tr.classify(obj)

      expect(class_id.empty?).to be
    end
  end
  context 'fail create tree' do
    it 'without array' do
      expect { DecisionTree::Tree.new({}) }.to raise_error(exp)
    end
    it ' with wrong array' do
      actions = []
      actions << { id: 11 }
      expect { DecisionTree::Tree.new(actions) }.to raise_error(exp)
      actions = []
      actions << { properties: { color: 'red', real: 'no' } }
      expect { DecisionTree::Tree.new(actions) }.to raise_error(exp)
    end
    it ' with array of duplicated actions' do
      actions = []
      actions << { id: 11, properties: { color: 'red', real: 'no' } }
      actions << { id: 11, properties: { color: 'black', real: 'no' } }
      expect { DecisionTree::Tree.new(actions) }.to raise_error(dup_exp)
    end
  end
end
