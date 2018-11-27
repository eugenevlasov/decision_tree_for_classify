# frozen_string_literal: true

class ClassificatorController < ApplicationController
  def classify
    obj = params[:obj]
    render json: { class_id: Decision::Tree.classify(obj) }
  end
end
