class HomeController < ApplicationController
    before_action :signed_in_user, only: [:index]

    def index
        @user=current_user
        @projects=(@user.projects+@user.productowner_projects+@user.scrummaster_projects).uniq
        @posts=Posts.all
    end

    private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
end
