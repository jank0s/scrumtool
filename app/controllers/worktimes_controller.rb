class WorktimesController < ApplicationController

  def index
    @id = params[:id]
    @worktimes = Worktime.where(task_id: @id).order(:day)
  end

  def update
    @time_id = params[:time_id]
    @time_done = params[:time_done]
    @time_remaining = params[:time_remaining]

    i = 0
    @time_id.each do |time|
      @time = Task.find(@time_id)

      @time.update_attributes(done: @time_done[i].to_f, remaining: @time_remaining[i].to_f)
      i+=1
    end

  end
end
