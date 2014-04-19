class UsertasksController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user


	def index
		@stories=current_user.activeproject.stories
		@userstories=@stories.joins(:tasks).where(:tasks => {:assigned_to => current_user}).uniq
        @usertask = Task.where(:assigned_to => current_user)
        @taskinprogress=Task.where.not(:startwork => nil)
        @todayswork = @usertask.joins(:worktimes).where(:worktimes => {:day => Date.today}).uniq
        @todaystory = []
        @todayswork.each do |t|
            @todaystory.push t.story_id
        end
        @todaystory=@todaystory.uniq
        @todaystories = Story.where(:id => @todaystory)
    end

    def stopwork
        @id = params[:id_task]
        @task = Task.find_by_id(@id)
        @diff = ((Time.now-@task.startwork)/3600)
        @diff = Integer(@diff*100)*0.01
        if (@diff > 0.01)
            @worktimes = Worktime.where(:task_id => @task.id, :day => Date.today)
            @taskremaining = @task.time_estimation
            if @worktimes.empty?  
                @remaining = @taskremaining-@diff  
                @worktime = Worktime.new(:task_id => @task.id, :day => Date.today, :done => @diff, :remaining => @remaining)
                @worktime.save
            else
                @worktime = @worktimes.first
                @done = @diff + @worktime.done
                if (@taskremaining-@done>=0)
                    @remaining = @taskremaining-@done
                else
                    @remaining = 0
                end
                @worktime.update_attributes(:done => @done, :remaining => @remaining)
            end
        end
        @task.update_attributes(:startwork => nil)
        redirect_to usertasks_url
    end

    def startwork
        @id = params[:id_task]
        @task = Task.find_by_id(@id)
        @task.update_attributes(:startwork => DateTime.now.in_time_zone)
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
