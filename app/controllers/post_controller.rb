class PostController < ApplicationController

  def new
    redirect_to '/' if session[:user_id].nil?
  end

  def create
    post = Post.new
    post.title = params[:title]
    post.content = params[:content]
    post.save

    redirect_to '/'
  end

  def edit
    redirect_to '/' if session[:user_id].nil?
    @post = Post.find(params[:post_id])
  end

  def update
    post = Post.find(params[:post_id])
    post.title = params[:title]
    post.content = params[:content]
    post.save

    redirect_to '/'
  end

  def delete
    Post.destroy(params[:post_id])

    redirect_to '/'
  end

end
