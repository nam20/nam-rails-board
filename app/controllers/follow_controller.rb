class FollowController < ApplicationController

  before_action  :authenticate_user, :set_following_user, only: [:follow, :unfollow]

  def follow

    if Follow.find_by(follower_id: session[:user_id], following_id: @following_user.id)
      redirect_to '/'
      return
    end

    follow = Follow.new
    follow.follower_id = session[:user_id]
    follow.following_id = @following_user.id
    follow.save

    redirect_to '/'

  end

  def unfollow

    unless follow = Follow.find_by(follower_id: session[:user_id], following_id: @following_user.id)
      redirect_to '/'
      return
    end

    Follow.destroy(follow.id)

    redirect_to '/'
  end

  private

  def authenticate_user
    redirect_to '' if session[:user_id].nil?
  end

  def set_following_user
    @following_user =  User.find_by(id: params[:id])

    redirect_to '/' if @following_user.nil?
  end
end
