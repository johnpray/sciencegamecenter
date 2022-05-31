class PlayerReviewsController < ApplicationController

  before_filter :signed_in_user,  only: [:create, :edit, :update, :destroy]
  before_filter :correct_user,    only: [:edit, :update, :destroy]

  def index
    # @player_reviews = PlayerReview.paginate(page: params[:page])
    redirect_to games_path
  end

  def show
    @player_review = PlayerReview.find(params[:id])
    @comment = Comment.new
  end

  def create
    @game = Game.find(params[:player_review][:game_id])
    @player_reviews = @game.player_reviews
    @player_review = PlayerReview.new(params[:player_review])
    @player_review.user = current_user
    if @player_review.save
      if current_user.is_admin?
        @player_review.approve!
        flash[:success] = "Player review created."
      else
        @player_review.make_pending!
        PlayerReviewMailer.notify_for_approval(@player_review).deliver_now
        flash[:success] = "Your review has been submitted and will show up on the site once it is approved. Thank you!"
      end
      redirect_to game_path(@game, anchor: :new_player_review)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @player_review.update_attributes(params[:player_review])
      if current_user.is_admin?
        flash[:success] = "Player review updated. #{undo_link}".html_safe
      else
        @player_review.make_pending!
        PlayerReviewMailer.notify_for_approval(@player_review).deliver_now
        flash[:success] = "Your revised review has been submitted and will show up on the site once it is approved. Thank you!"
      end
      redirect_to game_path(@player_review.game, anchor: :player_reviews)
    else
      render 'edit'
    end
  end

  def destroy
    @player_review = PlayerReview.find(params[:id])
    PlayerReview.find(params[:id]).destroy
    flash[:success] = "Player review destroyed. #{undo_link}".html_safe
    redirect_to game_path(@player_review.game)
  end

  private
    def correct_user
      @player_review = PlayerReview.find(params[:id])
      redirect_to(root_path) unless current_user?(@player_review.user) || current_user.is_admin?
    end

    def undo_link
      view_context.link_to("Undo", revert_version_path(@player_review.versions.scoped.last), method: :post)
    end
end
