class PostsController < ApplicationController

  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]


  def index
    @posts = Post.includes(:user, :likes).where(is_deleted: false).order(created_at: :desc)
    @current_user = User.includes(:followings, :followers).find(session[:user_id]) if session[:user_id]
  end

  def show
    @post = Post.includes(:user).find(params[:id])

    @post.comments = Comment.includes(:user)
                            .where( post_id: params[:id] )
                            .order(group_id: :desc , group_order: :asc)
  end

  def new
    @post = Post.new
  end

  def create

    post = Post.new(post_params)

    post.user_id = session[:user_id]
    post.is_deleted = false

    post.save

    redirect_to root_path
  end

  def edit
  end

  def update

    @post.update(post_params)

    redirect_to root_path
  end

  def destroy

    @post.update(is_deleted: true)

    redirect_to root_path
  end


  private

  def authenticate_user
    redirect_to root_path if session[:user_id].nil?
  end

  def set_post
    @post = Post.find_by(id: params[:id])

    redirect_to root_path if @post.nil? || session[:user_id] != @post.user_id
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

end
