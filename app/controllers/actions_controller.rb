# frozen_string_literal: true

class ActionsController < ApplicationController
  def create
    act = Action.create(class_id: params[:id],
                        properties: params[:properties])
    if act.valid?
      render json: act
    else
      render json: { error: 'wrong params' }, status: 500
    end
  end

  def index
    actions = Action.all
    render json: actions
  end
end
