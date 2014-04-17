class WorktimesController < ApplicationController
  def index
    @id = params[:id]
    @worktimes = Worktime.where(task_id: @id).order(:day)
  end
end
