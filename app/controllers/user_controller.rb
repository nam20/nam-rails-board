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
    user.is_deleted = false


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

    elsif user.is_deleted
      redirect_to '/user/login'

    else
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to '/'

      else
        redirect_to '/user/login'
      end
    end
  end

  def logout
    session.destroy
    redirect_to '/'
  end

  def delete
    if session[:user_id]
      redirect_to '/'
      return
    end

    user = User.find(session[:user_id])
    user.update(is_deleted: true)

    redirect_to '/'

  end

  def follow

    following_user = User.find_by(id: params[:user_id])

    if session[:user_id].nil? || following_user.nil?
      redirect_to '/'
      return
    end

    if Follow.find_by(follower_id: session[:user_id], following_id: following_user.id)
      redirect_to '/'
      return
    end

    follow = Follow.new
    follow.follower_id = session[:user_id]
    follow.following_id = following_user.id
    follow.save

    redirect_to '/'

  end

  def unfollow
    following_user = User.find_by(id: params[:user_id])

    if session[:user_id].nil? || following_user.nil?
      redirect_to '/'
      return
    end

    unless follow = Follow.find_by(follower_id: session[:user_id], following_id: following_user.id)
      redirect_to '/'
      return
    end

    Follow.destroy(follow.id)

    redirect_to '/'
  end

end
