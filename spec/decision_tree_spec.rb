# frozen_string_literal: true

require 'decision_tree'

RSpec.describe DecisionTree do
  let (:exp) { DecisionTree::ClassesIncorrect }
  let (:dup_exp) { DecisionTree::DuplicatedClassId }
  context 'create tree' do
    it 'from array' do
      actions = []
      actions << { id: 11, properties: { color: 'green', location: 'unknown' } }

      actions << { id: 12, properties: { color: 'red', real: 'no' } }
      actions << { id: 13, properties: { location: 'moscow' } }
      tr = DecisionTree::Tree.new(actions)
      expect(tr).to be
    end
    it 'fail without array' do
      expect { DecisionTree::Tree.new({}) }.to raise_error(exp)
    end
    it 'fail with wrong array' do
      actions = []
      actions << { id: 11 }
      expect { DecisionTree::Tree.new(actions) }.to raise_error(exp)
      actions = []
      actions << { properties: { color: 'red', real: 'no' } }
      expect { DecisionTree::Tree.new(actions) }.to raise_error(exp)
    end
    it 'fail with array of duplicated actions' do
      actions = []
      actions << { id: 11, properties: { color: 'red', real: 'no' } }
      actions << { id: 11, properties: { color: 'black', real: 'no' } }
      expect { DecisionTree::Tree.new(actions) }.to raise_error(dup_exp)
    end
  end
end
# begin
#   tr = DecisionTree::Tree.new(actions)
#   puts tr.to_hash.to_json
#   obj = { color: 'green', location: 'unknown', type: 'martian', weight: 'light' }
#   class_id = tr.classify(obj)
#   puts class_id
#   puts "Expect #{class_id} == 11"

#   obj = { real: 'no', type: 'cat', name: 'Murka' }
#   class_id = tr.classify(obj)
#   puts class_id
#   puts "Expect #{class_id} is []"
# rescue DecisionTree::ClassesIncorrect => e
#   puts e
# rescue DecisionTree::DuplicatedClassId => e
#   puts e
# end
