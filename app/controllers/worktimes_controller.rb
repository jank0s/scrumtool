class WorktimesController < ApplicationController

  def index
    @id = params[:id]
    @worktimes = Worktime.where(task_id: @id).order(:day)

    testdate = Date.new(2014, 4, 20)
    if @worktimes.last.day < testdate
      x = (testdate - @worktimes.last.day).to_i

      x.times do |i|
        Worktime.create(done: 0, remaining: 0, day: @worktimes.last.day + (i+1).days, task_id: @id)
      end
    end

  end

  def update   # LOOKING FOR ERRORS MISSING
    @time_id = params[:time_id]
    @time_done = params[:time_done]
    @time_remaining = params[:time_remaining]

    i = 0
    @time_id.each do |time|
      @time = Worktime.find(time)

      @time.update_attributes(done: @time_done[i].to_f, remaining: @time_remaining[i].to_f)
      i+=1
    end

    @id = Worktime.find(@time_id.first).task_id
    @worktimes = Worktime.where(task_id: @id).order(:day)
    render 'index'

  end

end
