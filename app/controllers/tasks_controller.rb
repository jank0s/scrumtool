class TasksController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user
    before_action :sm, only: [:new, :create]


  def index 
      @stories=current_user.activeproject.stories
      @sprintStories=@stories.where(finished: false)
  end

  def new
  	@story = Story.find(params[:id])

    @tasks = Task.where(story_id: @story.id)

  	@task = Task.new

    ap_id = current_user.activeproject_id

    #@users = Project.find(ap_id).teammembers
    @users = Project.find(ap_id).users
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_url
    else
      render "new"
    end
  end

  def accept
    @task = Task.find(params[:id])
    @task.assigned_to = current_user.id
    @task.proposed_id = nil
    if @task.save
      redirect_to tasks_url
    else
      redirect_to tasks_url
    end
  end

  def release
    @task = Task.find(params[:id])
    @task.assigned_to = nil
    if @task.save
      redirect_to tasks_url
    else
      redirect_to tasks_url
    end
  end

  def reject
    @task = Task.find(params[:id])
    @task.proposed_id = nil
    if @task.save
      redirect_to tasks_url
    else
      redirect_to tasks_url
    end
  end

private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end

    def correct_user
        redirect_to root_url unless current_user.activeproject!=nil
    end

    def sm #ti mors bit sm na temu projektu?
        redirect_to root_url unless (scrummaster? || admin?)
    end

    def task_params
      params.require(:task).permit(:name, :story_id, :proposed_id, :time_estimation)
    end
  

end
