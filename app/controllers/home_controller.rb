class HomeController < ApplicationController
    before_action :signed_in_user, only: [:index]

    def index
        @user=current_user
    end

    private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
end
