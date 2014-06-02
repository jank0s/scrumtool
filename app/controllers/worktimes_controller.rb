class WorktimesController < ApplicationController

  def index
    @id = params[:id]
    @t = Task.find(@id)
    today = Date.today
    @worktimes = Worktime.where(task_id: @id).where("day >= ?", @t.assigned_date.to_date)
                                              .where("day <= ?", today).order(:day)

    #testdate = Date.today
    #if @worktimes.last.day < testdate   # SPRAVT V HASH, DA VSE NAENKRAT ZAPISE
    #  @r = @worktimes.last.remaining
    #  x = (testdate - @worktimes.last.day).to_i
    #
    #  for i in 1..x
    #    Worktime.create(done: 0, remaining: @r, day: @worktimes.last.day + i.days, task_id: @id,
    #                    task_estimation: @task.time_estimation)
    #  end
    #end

  end

  def update   # LOOKING FOR ERRORS MISSING
    @time_id = params[:time_id]
    @time_done = params[:time_done]
    @time_remaining = params[:time_remaining]
    @time_day = params[:time_day]

    all = Worktime.where(task_id: params[:task_id], sprint_id: currently_running_sprint).order(:id)
    @t = Task.find(params[:task_id])

    #if @time_remaining.last.to_f == 0.0
    #  @t.update_attributes(completed: true)
    #else
    #  @t.update_attributes(completed: false)
    #end
    @lst = []
    today = Date.today
    i = 0
    j = 0
    inside = false
    all.each do |time|
      @time = Worktime.find(time.id)
      if @time.day == today && @time_remaining[i].to_f == 0.0
        @lst << @time.day
        @lst << @time_remaining[i].to_f
        @t.update_attributes(completed: true)
        inside = true
      end
      if @time.day > today
        i-=1
        @time.update_attributes(done: @time_done[j].to_f, remaining: @time_remaining[i].to_f)
        j+=1
        i+=1
      else
        @time.update_attributes(done: @time_done[j].to_f, remaining: @time_remaining[i].to_f)
        i+=1
        j+=1
      end
    end

    if !inside
      @t.update_attributes(completed: false)
    end


    #TUUUUUUUUUUUUKI DA SE VID SAMO ODKAR SI ASSIGNAN
    #@id = Worktime.find(@time_id.first).task_id
    #@worktimes = Worktime.where(task_id: @id).order(:day)
    today = Date.today
    @worktimes = Worktime.where(task_id: @t.id).where("day >= ?", @t.assigned_date.to_date)
    .where("day <= ?", today).order(:day)

    if (params[:from_task]!=nil)
      redirect_to usertasks_url 
    else
      render 'index'
    end
  end

end
