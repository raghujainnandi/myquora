class LikesController < ApplicationController
  before_action :find_comment
  before_action :find_like, only: [:destroy]

  def create
    # @comment.likes.create(user_id: current_user.id)
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @comment.likes.create(user_id: current_user.id)
    end
    redirect_back fallback_location: @question
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "cannnot unlike"
    else
      @like.destroy
    end
    redirect_back fallback_location: @question
  end

  def find_like
    @like = @comment.likes.find(params[:id])
  end

  private
  def find_comment
    @comment = Comment.find(params[:comment_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, comment_id:
        params[:comment_id]).exists?
  end

end

