class ToppagesController < ApplicationController
  def index
    if logged_in?
      @event = current_user.events.build  # form_with 用
      @events = current_user.feed_events.order(id: :desc).page(params[:page])
    end
  end
end
