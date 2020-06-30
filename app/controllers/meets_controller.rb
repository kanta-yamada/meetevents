class MeetsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    event = Event.find(params[:event_id])
    current_user.interest(event)
    flash[:sucess] = 'イベントへの参加が完了しました。'
    redirect_to '/'
  end

  def destroy
    event = Event.find(params[:event_id])
    current_user.uninterest(event)
    flash[:sucess] = 'イベントをキャンセルしました。'
    redirect_to '/'
  end
end
