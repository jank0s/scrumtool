class ProjectsController < ApplicationController
    before_action :signed_in_user, only: [:index]
    before_action :admin_user, only: [:index, :create, :edit, :update]
    before_action :sm, only: [:index, :edit, :update, :create]

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
            if (admin?)
                redirect_to projects_url
            else
                redirect_to root_url
            end
        else
            render 'edit'
        end
    end

    def destroy
    	Project.find(params[:id]).destroy
        @users = User.where(activeproject_id: params[:id])
        @users.each do |user|
            user.update_attributes(:activeproject_id => nil)
        end
    	redirect_to projects_url
    end

	private
	def project_params
        if (admin? || scrummaster?)
            params.require(:project).permit(:name, :description, :scrummaster_id, :productowner_id, :user_ids => [])
        end

    end

    def sm
        redirect_to root_url unless (scrummaster? || admin?)
    end

	def signed_in_user
		redirect_to signin_url unless signed_in?
    end

    def admin_user
        redirect_to root_url unless (admin? || scrummaster?)
    end
end
