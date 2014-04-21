class HomeController < ApplicationController
    before_action :signed_in_user, only: [:index]

    def index
        @user=current_user
        @projects=(@user.projects+@user.productowner_projects+@user.scrummaster_projects).uniq
        #@posts=Post.all
        @posts=Post.where(project_id: current_user.activeproject_id).order("created_at DESC").all
        @post=Post.new
    end

    private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
end
