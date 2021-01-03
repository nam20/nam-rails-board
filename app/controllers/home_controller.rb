class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user, :likes).where(is_deleted: false).order(created_at: :desc)
    @user = User.includes(:followings, :followers).find(session[:user_id]) if session[:user_id]

  end
end
