class SessionController < ApplicationController

  before_action :not_authenticate_user, only: [:login, :find]

  def login
  end

  def find
    user = User.find_by(name: params[:name])
    if user.nil?
      redirect_to '/session/login'

    elsif user.is_deleted
      redirect_to '/session/login'

    else
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to '/'

      else
        redirect_to '/session/login'
      end
    end
  end

  def logout
    session.destroy
    redirect_to '/'
  end

  private

  def not_authenticate_user
    redirect_to '/' if session[:user_id]
  end
end
