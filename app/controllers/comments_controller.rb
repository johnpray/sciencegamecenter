class CommentsController < ApplicationController

	before_filter :signed_in_user,  only: [:create, :edit, :update, :destroy]
	before_filter :correct_user,    only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    if @comment.save
      if current_user.is_admin?
        @comment.approve!
        flash[:success] = "Comment created and published."
      else
        @comment.make_pending!
        CommentMailer.notify_for_approval(@comment).deliver_now
        flash[:success] = "Your comment has been submitted and will show up on the site once it is approved. Thank you!"
      end
      redirect_to @comment.commentable
    else
    	@player_review = @comment.commentable
    	render "#{@comment.commentable_type.underscore.pluralize}/show"
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(params[:comment])
      if current_user.is_admin?
        @comment.approve!
        flash[:success] = "Comment updated."
      else
        @comment.make_pending!
        CommentMailer.notify_for_approval(@comment).deliver_now
        flash[:success] = "Your revised comment has been submitted and will show up on the site once it is approved. Thank you!"
      end
      redirect_to @comment.commentable
    else
      render 'edit'
    end
  end

  def destroy
  	comment = Comment.find(params[:id])
    Comment.find(params[:id]).destroy
    flash[:success] = "Comment destroyed now and forever."
    redirect_to comment.commentable
  end

  private
    def correct_user
      @comment = Comment.find(params[:id])
      redirect_to(root_path) unless current_user?(@comment.user) || current_user.is_admin?
    end
end
