# frozen_string_literal: true

class ClassificatorController < ApplicationController
  def classify
    params.require(:obj).permit!
    obj = params[:obj].to_hash
    if obj.is_a?(Hash)
      render json: { class_id: Decision::Tree.classify(obj) }
    else
      render json: { error: 'obj isnt hash' }, status: 500
    end
  rescue ActionController::ParameterMissing => e
    render json: { error: e }, status: 500
  end
end
