class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:sucess] = 'User registration was successful'
      redirect_to @user
    else
      flash.now[:danger] = 'User registration was failed'
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
  end
  
  def joins
    @user = User.find(params[:id])
    @joinings = @user.joinings.page(params[:page])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
