class UsertasksController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user


	def index
		@stories=current_user.activeproject.stories
		@userstories=@stories.joins(:tasks).where(:tasks => {:assigned_to => current_user}).uniq

        @usertask = Task.where(:assigned_to => current_user)
        @taskinprogress=[]
        @usertask.each  do |task|
            if (task.startwork_date != nil && task.endwork_date == nil)
                @taskinprogress.push task
            end
        end
    end

    def startwork
        @id = params[:id_task]
        @task = Task.find_by_id(@id)
        @task.update_attributes(:startwork_date => DateTime.now.in_time_zone)
        redirect_to usertasks_url
    end

private
	def signed_in_user
        redirect_to signin_url unless signed_in?
    end

    def correct_user
        redirect_to root_url unless current_user.activeproject!=nil
    end
end
