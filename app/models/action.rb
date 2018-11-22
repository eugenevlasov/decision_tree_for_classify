# frozen_string_literal: true

class Action < ApplicationRecord
  validates :class_id, presence: true
  validates :properties, presence: true
end
