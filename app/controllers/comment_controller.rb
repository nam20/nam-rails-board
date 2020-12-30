class CommentController < ApplicationController
  def create
    user = User.find(session[:user_id])
    post = Post.find(params[:post_id])

    if(user.nil? || post.nil?)
      redirect_to '/'
      return
    end

    comment = Comment.new

    if params[:comment_id]
      co = Comment.find(params[:comment_id])
      sort_comments = Comment
                             .where(post_id: params[:post_id], group_id: co.group_id)
                             .where("group_order > #{co.group_order}")


      sort_comments.scoping do
        Comment.update_all("group_order = group_order + 1")
      end



      #sort_comments.update()

       # sort_comments.each do |comment|
       #   comment.increment(:group_order, 1)
       #   comment.save
       # end


      comment.group_id = co.group_id
      comment.group_order = co.group_order + 1
      comment.depth = co.depth + 1
    else
      co = Comment.where(post_id: post.id).order(:group_id).last
      comment.group_id = (co && co.group_id || 0) + 1
      comment.group_order = 0
      comment.depth = 0
    end

    comment.content = params[:content]
    comment.user_id = user.id
    comment.post_id = post.id

    comment.save

    redirect_to "/post/#{params[:post_id]}"
  end

  def delete
    user = User.find(session[:user_id])
    comment = Comment.find(params[:comment_id])

    if(user.nil? || comment.nil?)
      redirect_to '/'
      return
    end

    Comment.destroy(params[:comment_id])

    redirect_to "/post/#{comment.post_id}"
  end
end
