# frozen_string_literal: true

require 'decision_tree'

class Decision
  Tree = DecisionTree::Tree.new
end

actions = ConvertActions.call(Action.all)
Decision::Tree.make(actions)
