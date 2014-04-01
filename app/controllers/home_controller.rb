class HomeController < ApplicationController
    before_action :signed_in_user, only: [:index]

    def index
        @projects=Project.all
    end

    private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
end
