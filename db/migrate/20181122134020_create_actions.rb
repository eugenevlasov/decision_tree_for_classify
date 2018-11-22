# frozen_string_literal: true

class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.integer :class_id, unique: true, null: false
      t.json :properties, null: false
      t.timestamps
    end
  end
end
