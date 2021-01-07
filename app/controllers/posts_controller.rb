class PostsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]


  def index
    @posts = Post.kept.includes(:user, :likes).order(created_at: :desc)
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
    post.user = current_user

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

    @post.discard

    redirect_to root_path, notice: "Post removed"
  end


  private

  def set_post
    @post = Post.find_by(id: params[:id])

    redirect_to root_path if @post.nil? || current_user.id != @post.user_id
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

end
