class CommentsController < ApplicationController

  before_action :authenticate_user!

  def create

    post = Post.find_by(id: params[:post_id])

    if post.nil?
      redirect_to root_path
      return
    end

    comment = Comment.new

    if params[:comment_id]
      parent_comment = Comment.find_by(id: params[:comment_id])

      if parent_comment.nil?
        redirect_to root_path
        return
      end

      sort_comments = Comment
                             .where(post_id: params[:post_id], group_id: parent_comment.group_id)
                             .where("group_order > #{parent_comment.group_order}")

      sort_comments.scoping do
        Comment.update_all("group_order = group_order + 1")
      end

      comment.group_id = parent_comment.group_id
      comment.group_order = parent_comment.group_order + 1
      comment.depth = parent_comment.depth + 1
    else
      last_comment = Comment.where(post_id: post.id).order(:group_id).last
      comment.group_id = (last_comment && last_comment.group_id || 0) + 1
      comment.group_order = 0
      comment.depth = 0
    end

    comment.content = params[:content]
    comment.user = current_user
    comment.post = post

    comment.save

    redirect_to post_path(params[:post_id])
  end

  def delete

    comment = Comment.find_by(id: params[:comment_id])

    if comment.nil? || current_user.id != comment.user_id
      redirect_to root_path
      return
    end

    comment.discard

    redirect_to post_path(comment.post_id)
  end

end
