class ScreenshotsController < ApplicationController

  #force_ssl except: :index
  before_filter :signed_in_user
  before_filter :admin_user

  def index
    @game = Game.find(params[:game_id])
    @screenshots = @game.screenshots
  end

  def new
    @game = Game.find(params[:game_id])
    @screenshot = @game.screenshots.build
  end

  def create
    @game = Game.find(params[:game_id])
    @screenshot = @game.screenshots.build(params[:screenshot])
    if @screenshot.save
      flash[:success] = "Screenshot uploaded."
      redirect_to game_screenshots_path(@game)
    else
      flash[:error] = "Screenshot could not be saved. See error messages below and try again."
      render 'new'
    end
  end

  def edit
    @screenshot = Screenshot.find(params[:id])
    @game = @screenshot.game
  end

  def update
    @screenshot = Screenshot.find(params[:id])
    if @screenshot.update_attributes(params[:screenshot])
      flash[:success] = "Screenshot uploaded."
      redirect_to game_screenshots_path(@screenshot.game)
    else
      flash[:error] = "Screenshot could not be saved. See error messages below and try again."
      render 'edit'
    end
  end

  def destroy
    screenshot = Screenshot.find(params[:id])
    Screenshot.find(params[:id]).destroy
    flash[:success] = "Screenshot destroyed now and forever."
    redirect_to game_screenshots_path(screenshot.game)
  end
end
