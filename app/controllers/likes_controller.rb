class LikesController < ApplicationController

  before_action :authenticate_user!

  def like

    if Like.find_by(user_id: current_user.id, post_id: params[:id])
      redirect_to root_path
      return
    end

    like = Like.new
    like.user_id = current_user.id
    like.post_id = params[:id]
    like.save

    redirect_to post_path(params[:id])

  end

  def unlike

    unless like = Like.find_by(user_id: current_user.id, post_id: params[:id])
      redirect_to root_path
      return
    end

    Like.destroy(like.id)

    redirect_to post_path(params[:id])
  end

end
