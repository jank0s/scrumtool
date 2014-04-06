class TasksController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user
    before_action :sm, only: [:new, :create]


  def index # "index bos itak meu u index-u od storiesov?"
  	puts params
    @tasks = Task.where(story_id: 1)  # 1 for testing
  end

  def new
  	@story = Story.find(params[:id])
  	@task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to stories_url
    else
      render "new"
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
      params.require(:task).permit(:name, :story_id)
    end
  

end
