class ScreenshotsController < ApplicationController

  force_ssl
  before_filter :signed_in_user
  before_filter :admin_user

  def index
    @game = Game.find(params[:game_id])
    @screenshots = @game.screenshots
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
