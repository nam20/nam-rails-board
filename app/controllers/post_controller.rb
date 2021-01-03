class PostController < ApplicationController

  def show
    @post = Post.includes(:user).find(params[:post_id])

    @comments = Comment.includes(:user)
                       .where( post_id: params[:post_id] )
                       .order(group_id: :desc , group_order: :asc)
  end

  def new
    redirect_to '/' if session[:user_id].nil?
  end

  def create

    if session[:user_id].nil?
      redirect_to '/'
      return
    end

    post = Post.new
    post.title = params[:title]
    post.content = params[:content]
    post.image = params[:image] if params[:image]
    post.user_id = session[:user_id]
    post.is_deleted = false

    post.save

    redirect_to '/'
  end

  def edit
    redirect_to '/' if session[:user_id].nil?
    @post = Post.find(params[:post_id])
  end

  def update

    post = Post.find_by(id: params[:post_id])

    if session[:user_id].nil? || (session[:user_id] != post.user_id)
      redirect_to '/'
      return
    end

    post.title = params[:title]
    post.content = params[:content]
    post.image = params[:image] if params[:image]

    post.save

    redirect_to '/'
  end

  def delete

    post = Post.find_by(id: params[:post_id])

    if session[:user_id].nil? || (session[:user_id] != post.user_id)
      redirect_to '/'
      return
    end

    post.update(is_deleted: true)

    redirect_to '/'
  end

  def like
    if session[:user_id].nil?
      redirect_to '/'
      return
    end

    if Like.find_by(user_id: session[:user_id], post_id: params[:post_id])
      redirect_to '/'
      return
    end

    like = Like.new
    like.user_id = session[:user_id]
    like.post_id = params[:post_id]
    like.save

    redirect_to "/post/#{params[:post_id]}"

  end

  def unlike
    if session[:user_id].nil?
      redirect_to '/'
      return
    end

    unless like = Like.find_by(user_id: session[:user_id], post_id: params[:post_id])
      redirect_to '/'
      return
    end

    Like.destroy(like.id)

    redirect_to "/post/#{params[:post_id]}"
  end

end
