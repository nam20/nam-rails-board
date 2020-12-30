class HomeController < ApplicationController
  def index
    @posts = Post.includes(:user, :likes).order(created_at: 'desc')

  end
end
