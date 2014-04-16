class UsertasksController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user


	def index
		@stories=current_user.activeproject.stories
		@userstories=@stories.joins(:tasks).where(:tasks => {:assigned_to => current_user}).uniq

        @usertask = Task.where(:assigned_to => current_user)
        @taskinprogress=[]
        @todayswork = []

        @usertask.each  do |task|
            @worktimes = Worktime.where(:task_id => task.id)
            if (!@worktimes.empty?)
                @worktimes.each do |w|
                    if (w.startwork != nil && w.endwork != nil)
                        if (w.startwork.to_date == Date.today)
                            @todayswork.push task
                        end
                    end
                    if (w.startwork != nil && w.endwork == nil)
                        @taskinprogress.push task
                    end
                end
            end
        end

        

    end

    def stopwork
        @id = params[:id_task]
        @task = Task.find_by_id(@id)
        @worktimes = Worktime.where(task_id: @id)
        if (!@worktimes.empty?)
            @worktimes.each do |w|
                if (w.startwork != nil)
                    w.update_attributes(:endwork => DateTime.now.in_time_zone)
                end
            end
        end
        redirect_to usertasks_url
    end

    def startwork
        @id = params[:id_task]
        @task = Task.find_by_id(@id)
        @worktime = Worktime.new(:startwork => DateTime.now.in_time_zone, :task_id => @id)
        @worktime.save
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
