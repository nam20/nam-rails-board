class LikeController < ApplicationController

  before_action :authenticate_user, only: [:like, :unlike]

  def like

    if Like.find_by(user_id: session[:user_id], post_id: params[:id])
      redirect_to root_path
      return
    end

    like = Like.new
    like.user_id = session[:user_id]
    like.post_id = params[:id]
    like.save

    redirect_to post_path(params[:id])

  end

  def unlike

    unless like = Like.find_by(user_id: session[:user_id], post_id: params[:id])
      redirect_to '/'
      return
    end

    Like.destroy(like.id)

    redirect_to post_path(params[:id])
  end

  private

  def authenticate_user
    redirect_to root_path if session[:user_id].nil?
  end
end
