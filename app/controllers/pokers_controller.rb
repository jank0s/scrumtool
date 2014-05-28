class PokersController < ApplicationController
	before_action :signed_in_user
    before_action :correct_user

	def index
		@users = User.where(activeproject_id: current_user.activeproject)
    end
    def new
    	@ids = params[:user_checkbox]
    	@users = User.where(id: @ids)
   	end


   	private

    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
    def correct_user
        redirect_to root_url unless current_user.activeproject!=nil
    end
end
