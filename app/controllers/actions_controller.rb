# frozen_string_literal: true

class ActionsController < ApplicationController
  def create
    act = Action.create(class_id: params[:id],
                        properties: params[:properties])
    if act.valid?
      Decision::Tree.make(ConvertActions.call(Action.all))
      render json: act
    else
      render json: { error: 'wrong params' }, status: 500
    end
  end

  def destroy
    act = Action.find_by(class_id: params[:id])
    if act
      act.destroy
      Decision::Tree.make(ConvertActions.call(Action.all))
      render json: { success: 'ok' }
    else
      render json: { error: 'no action' }, status: 500
    end
  end

  def index
    actions = Action.all
    render json: { actions: actions }
  end
end
