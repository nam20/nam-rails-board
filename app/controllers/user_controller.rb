class UserController < ApplicationController

  def join
    redirect_to '/' if session[:user_id]
  end

  def create

    if User.find_by(name: params[:name])
      redirect_to '/user/join'
      return
    end

    user = User.new
    user.name = params[:name]
    user.email = params[:email]
    user.password = params[:password]
    user.password_confirmation = params[:password_confirmation]


    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/user/join'
    end

  end

  def login
    redirect_to '/' if session[:user_id]
  end

  def find
    user = User.find_by(name: params[:name])
    if user.nil?
      redirect_to '/user/login'
    else
      if auth = user.authenticate(params[:password])
        session[:user_id] = auth.id
        redirect_to '/'
      else
        redirect_to '/user/login'
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to '/'
  end

end
