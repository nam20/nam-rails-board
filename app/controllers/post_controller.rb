class PostController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :edit, :update, :delete]
  before_action :set_post, only: [:edit, :update, :delete]

  def show
    @post = Post.includes(:user).find(params[:id])

    @comments = Comment.includes(:user)
                       .where( post_id: params[:id] )
                       .order(group_id: :desc , group_order: :asc)
  end

  def new
  end

  def create

    post = Post.new(post_params)

    post.user_id = session[:user_id]
    post.is_deleted = false

    post.save

    redirect_to '/'
  end

  def edit
  end

  def update

    @post.update(post_params)

    redirect_to '/'
  end

  def delete

    @post.update(is_deleted: true)

    redirect_to '/'
  end


  private

  def authenticate_user
    redirect_to '/' if session[:user_id].nil?
  end

  def set_post
    @post = Post.find_by(id: params[:id])

    redirect_to '/' if session[:user_id] != @post.user_id
  end

  def post_params
    params.permit(:title, :content, :image)
  end


end
