class JoinController < ApplicationController

  before_action :not_authenticate_user, only: [:join, :create]

  def join
    @user = User.new
  end

  def create

    @user_params = user_params

    if User.find_by(name: @user_params[:name])
      redirect_to '/join'
      return
    end

    user = User.new(@user_params)
    user.is_deleted = false


    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/join'
    end

  end

  private

  def not_authenticate_user
    redirect_to '/' if session[:user_id]
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
