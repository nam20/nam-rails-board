class SessionController < ApplicationController

  before_action :not_authenticate_user, only: [:login, :find]

  def login
    @user = User.new
  end

  def find
    @user_params = user_params
    user = User.find_by(name: @user_params[:name])

    if user.nil?
      redirect_to login_path

    elsif user.is_deleted
      redirect_to login_path

    else
      if user.authenticate(@user_params[:password])
        session[:user_id] = user.id
        redirect_to root_path

      else
        redirect_to login_path
      end
    end
  end

  def logout
    session.destroy
    redirect_to root_path
  end

  private

  def not_authenticate_user
    redirect_to root_path if session[:user_id]
  end

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
