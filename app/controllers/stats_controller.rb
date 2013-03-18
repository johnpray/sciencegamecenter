class StatsController < ApplicationController
	before_filter :signed_in_user
	before_filter :admin_user
	def index

	end
end