class WorktimesController < ApplicationController
  def index
    @task_id = params[:id]
    @worktimes = Worktime.where(task_id: @task_id)
  end
end
