class CommentsController < ApplicationController

	before_filter :signed_in_user,  only: [:create, :destroy]
	before_filter :correct_user,    only: [:destroy]

  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      if current_user.is_admin?
        @comment.approve!
        flash[:success] = "Comment created and published."
      else
        @comment.make_pending!
        # CommentMailer.notify_for_approval(@comment).deliver
        flash[:success] = "Your comment has been submitted and will show up on the site once it is approved. Thank you!"
      end
      redirect_to @comment.commentable
    else
      render template: "#{@comment.commentable_type}/show"
    end
  end

  def destroy
  	comment = Comment.find(params[:id])
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment destroyed now and forever."
    redirect_to game_path(player_review.game)
  end

  private
    def correct_user
      @comment = Comment.find(params[:id])
      redirect_to(root_path) unless current_user?(@comment.user) || current_user.is_admin?
    end
end
