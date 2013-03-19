class StatsController < ApplicationController
	before_filter :signed_in_user
	before_filter :admin_user
	def index
		@number = params[:number].present? ? params[:number].to_i : 3
		@unit = params[:unit].present? ? params[:unit] : 'weeks'

		@users_chart_data = User.chart_data(@number.send(@unit).ago)
		@reviews_chart_data = PlayerReview.chart_data(@number.send(@unit).ago)
		@games_chart_data = Game.chart_data(@number.send(@unit).ago)
	end
end