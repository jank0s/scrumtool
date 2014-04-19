class WorktimesController < ApplicationController

  def index
    @id = params[:id]
    @worktimes = Worktime.where(task_id: @id).order(:day)

    testdate = Date.new(2014, 4, 23)
    if @worktimes.last.day < testdate   # SPRAVT V HASH, DA VSE NAENKRAT ZAPISE
      @r = @worktimes.last.remaining
      x = (testdate - @worktimes.last.day).to_i

      for i in 1..x
        Worktime.create(done: 0, remaining: @r, day: @worktimes.last.day + i.days, task_id: @id)
      end
    end

  end

  def update   # LOOKING FOR ERRORS MISSING
    @time_id = params[:time_id]
    @time_done = params[:time_done]
    @time_remaining = params[:time_remaining]


    @t = Task.find(params[:task_id])
    if @time_remaining.last.to_i == 0
      @t.update_attributes(completed: true)
    else
      @t.update_attributes(completed: false)
    end

    i = 0
    @time_id.each do |time|
      @time = Worktime.find(time)

      @time.update_attributes(done: @time_done[i].to_f, remaining: @time_remaining[i].to_f)
      i+=1
    end

    @id = Worktime.find(@time_id.first).task_id
    @worktimes = Worktime.where(task_id: @id).order(:day)
    if (params[:from_task]!=nil)
      redirect_to usertasks_url 
    else
      render 'index'
    end
  end

end
