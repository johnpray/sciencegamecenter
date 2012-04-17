class PlayerReviewsController < ApplicationController

  force_ssl                       except: [:index]
  before_filter :signed_in_user,  only: [:edit, :update, :destroy]
  before_filter :correct_user,    only: [:edit, :update, :destroy]
  

  def index
    @player_reviews = PlayerReview.paginate(page: params[:page])
  end

  def create
    @game = Game.find(params[:player_review][:game_id])
    @player_reviews = @game.player_reviews
    @player_review = PlayerReview.new(params[:player_review])
    if @player_review.save
      if @current_user.is_admin?
        @player_review.approve!
        flash[:success] = "Player review created."
      else
        @player_review.set_pending!
        PlayerReviewMailer.notify_for_approval(@player_review).deliver
        flash[:success] = "Your review has been submitted and will show up on the site once it is approved. Thank you!"
      end
      redirect_to @game
    else
      render template: 'games/show'
    end
  end

  def edit
  end

  def update
    if @player_review.update_attributes(params[:player_review])
      flash[:success] = "Player review #{@player_review.title} for #{@player_review.game.title} updated."
      redirect_to @player_review.game
    else
      render 'edit'
    end
  end

  def destroy
    player_review = PlayerReview.find(params[:id])
    PlayerReview.find(params[:id]).destroy
    flash[:success] = "Player review #{@player_review.title} for #{@player_review.game.title} and all its reviews and comments have been destroyed now and forever."
    redirect_to game_path(player_review.game)
  end


  private
    def correct_user
      @player_review = PlayerReview.find(params[:id])
      redirect_to(root_path) unless current_user?(@player_review.user) || current_user.is_admin?
    end
end
