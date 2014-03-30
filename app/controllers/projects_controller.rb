class ProjectsController < ApplicationController
    before_action :signed_in_user, only: [:index, :destroy]
    before_action :admin_user, only: [:index, :destroy]

	def index
		@users = User.all
        @projects=Project.search(params[:search])
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

    def edit
        @project = Project.find(params[:id])
    end	

    def update
        @project = Project.find(params[:id])
        if @project.update_attributes(project_params)
            redirect_to projects_url
        else
            render 'edit'
        end
    end

    def destroy
    	Project.find(params[:id]).destroy
    	redirect_to projects_url
    end

	private
	def project_params
        if admin?
            params.require(:project).permit(:name, :description, :scrummaster_id, :productowner_id)
        end

    end

	def signed_in_user
		redirect_to signin_url unless signed_in?
    end

    def admin_user
        redirect_to root_url unless admin?
    end
end
