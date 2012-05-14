class VersionsController < ApplicationController

  before_filter :signed_in_user
  before_filter :correct_user

	def revert
		if @version.reify
	    @version.reify.save!
	  else
	    @version.item.destroy
	  end
	  flash[:success] = "Undid #{@version.event}."
	  redirect_to :back
	end

	private
		def correct_user
      @version = Version.find(params[:id])
      redirect_to(root_path) unless admin? || current_user?(User.find(@version.whodunnit.to_i))
    end
end