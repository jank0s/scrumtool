class UsertasksController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user


	def index
		@stories=current_user.activeproject.stories
		@userstories=@stories.joins(:tasks).where(:tasks => {:assigned_to => current_user})

    end

private
	def signed_in_user
        redirect_to signin_url unless signed_in?
    end

    def correct_user
        redirect_to root_url unless current_user.activeproject!=nil
    end
end
