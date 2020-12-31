class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user, :likes).order(created_at: :desc)
    @user = User.find(session[:user_id]) if session[:user_id]
  end
end
