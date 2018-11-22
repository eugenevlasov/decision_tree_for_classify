# frozen_string_literal: true

require 'active_support/json'

module DecisionTree
  Key = Struct.new(:key, :values, :no_key)
  Value = Struct.new(:name, :has_node, :class_id)
  class ClassesIncorrect < StandardError
    def initialize(obj = nil)
      msg = if obj
              "#{obj} is not include keys :id, :properties"
            else
              'classes must be is_a?(Array)'
            end
      super(msg)
    end
  end
  class DuplicatedClassId < StandardError
    def initialize(obj)
      msg = "#{obj} id already added"
      super(msg)
    end
  end
  class Tree
    def initialize(classes)
      @classes = classes
      @tree = Key.new(nil, [], nil)
      check_classes
      make_tree
    end

    def classify(obj)
      t = @tree
      while t
        if obj.key?(t[:key])
          key = t[:key]
          val = t[:values].detect { |v| v[:name] == obj[key] }
          return [] unless val
          return val[:class_id] if val[:class_id]

          t = val[:has_node]
        else
          return [] unless t[:no_key]

          t = t[:no_key]
        end
      end
    end

    def to_hash
      tree_to_hash(@tree)
    end

    private

    attr_reader :classes

    def check_classes
      raise ClassesIncorrect unless classes&.is_a?(Array)

      ids = []
      classes.each do |c|
        raise ClassesIncorrect, c unless c.key?(:id) && c.key?(:properties)
        raise DuplicatedClassId, c if ids.include? c[:id]

        ids << c[:id]
      end
    end

    def make_tree
      classes.each do |c|
        @tree = add_node(@tree, c[:properties], c[:id])
      end
    end

    def add_node(rn, trn, id)
      key = trn.keys.min
      return Value.new(nil, nil, nil) unless key

      rn ||= Key.new(key, [Value.new(trn[key], nil, nil)], nil)
      if rn[:key]
        key = rn[:key] if trn.key?(rn[:key])
      else
        rn = Key.new(key, [Value.new(trn[key], nil, nil)], nil)
      end
      if rn[:key] == key
        val = rn[:values].detect { |t| t[:name] == trn[key] }
        unless val
          val = Value.new(trn[key], nil, nil)
          rn[:values] << val
        end
        trn.delete(key)
        if trn.keys.empty?
          val[:class_id] = id
          return rn
        end
        val[:has_node] = add_node(val[:has_node], trn, id)
      else
        rn[:no_key] = add_node(rn[:no_key], trn, id)
      end
      rn
    end

    def tree_to_hash(tree)
      return [] unless tree

      h = { key: tree[:key], values: {} }
      tree[:values].each do |val|
        h[:values][val[:name]] = tree_to_hash(val[:has_node]) if val[:has_node]
        h[:values][val[:name]] = [val[:class_id]] if val[:class_id]
      end
      h[:default] = tree_to_hash(tree[:no_key])
      h
    end
  end
end
