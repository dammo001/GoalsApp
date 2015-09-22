class CommentsController < ApplicationController
  before_action :redirect_if_logged_out

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      if @comment.commentable.class == User
        redirect_to user_url(@comment.commentable)
      else
        redirect_to goal_url(@comment.commentable)
      end
    else
      flash[:errors] = @comment.errors.full_messages
      if @comment.commentable.class == User
        redirect_to user_url(@comment.commentable)
      else
        redirect_to goal_url(@comment.commentable)
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    if @comment.commentable.class == User
      redirect_to user_url(@comment.commentable)
    else
      redirect_to goal_url(@comment.commentable)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :commentable_id, :commentable_type)
  end
end
