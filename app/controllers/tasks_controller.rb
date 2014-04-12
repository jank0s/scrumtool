class TasksController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user
    before_action :sm, only: [:new, :create]


  def index 
      @stories=current_user.activeproject.stories
      @sprintStories=[]
      @sprints = Sprint.all
      @current_sprint
      @sprints.each do |sprint|
        if (sprint.end >= Date.today && sprint.start <= Date.today)
          @current_sprint = sprint.id
        end
      end
      if (@current_sprint != nil)
            @sprintStories=@stories.where(sprint_id: @current_sprint, finished: false)
      end
      @userstories=@stories.joins(:tasks).where(:tasks => {:assigned_to => current_user})
  end

  def new
  	@story = Story.find(params[:id])

    @tasks = Task.where(story_id: @story.id)

  	@task = Task.new

    ap_id = current_user.activeproject_id
    @users = Project.find(ap_id).users
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = "Task successfully saved."
      redirect_to tasks_url
    else
      #redirect_to indextask_url(:id => @task.story_id)
      ap_id = current_user.activeproject_id
      @users = Project.find(ap_id).users
      @story = Story.find(@task.story.id)
      @tasks = Task.where(story_id: @story.id)
      render "new"
    end
  end

  def accept
    @task = Task.find(params[:id])
    @task.assigned_to = current_user.id
    @task.proposed_id = nil
    if @task.save
      flash[:success] = "Task successfully accepted."
      redirect_to tasks_url
    else
      flash[:warning] = "Task is not successfully accepted."
      redirect_to tasks_url
    end
  end

  def release
    @task = Task.find(params[:id])
    @task.assigned_to = nil
    if @task.save
      flash[:success] = "Task successfully released."
      redirect_to tasks_url
    else
      flash[:warning] = "Task is not successfully released."
      redirect_to tasks_url
    end
  end

  def reject
    @task = Task.find(params[:id])
    @task.proposed_id = nil
    if @task.save
      flash[:success] = "Task successfully rejected."
      redirect_to tasks_url
    else
      flash[:warning] = "Task is not successfully rejected."
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
