class ProjectsController < ApplicationController
    before_action :signed_in_user, only: [:index, :destroy]
    before_action :admin_user, only: [:index, :destroy]

	def index
		@users = User.all
		@projects = Project.all
	end

	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
        if @project.save
            redirect_to projects_url
        else
            render "new"
        end
	end

	

    def destroy
    	Project.find(params[:id]).destroy
    	redirect_to projects_url
    end

	private
	def project_params
        if admin?
            params.require(:project).permit(:name, :description)
        end

    end

	def signed_in_user
		redirect_to signin_url unless signed_in?
    end

    def admin_user
        redirect_to root_url unless admin?
    end
end
