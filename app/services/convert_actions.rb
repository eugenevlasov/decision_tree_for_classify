# frozen_string_literal: true

module ConvertActions
  def self.call(actions)
    actions.map { |t| { id: t[:class_id], properties: t[:properties] } }
  end
end
