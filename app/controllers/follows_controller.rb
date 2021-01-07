class FollowsController < ApplicationController

  before_action :authenticate_user!, :set_following_user

  def follow

    if Follow.find_by(follower_id: current_user.id, following_id: @following_user.id)
      redirect_to root_path
      return
    end

    follow = Follow.new
    follow.follower_id = current_user.id
    follow.following_id = @following_user.id
    follow.save

    redirect_to root_path

  end

  def unfollow

    unless follow = Follow.find_by(follower_id: current_user.id, following_id: @following_user.id)
      redirect_to root_path
      return
    end

    Follow.destroy(follow.id)

    redirect_to root_path
  end

  private

  def set_following_user
    @following_user =  User.find_by(id: params[:id])

    redirect_to root_path if @following_user.nil?
  end
end
