class EventsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @events = current_user.events.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @event.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def event_params
    params.require(:event).permit(:title, :content, :place, :time)
  end
  
  def correct_user
    @event = current_user.events.find_by(id: params[:id])
    unless @event
      redirect_to root_url
    end
  end
end
