class ProgressController < ApplicationController
    before_action :signed_in_user

    def index
      @start_lst = []
    	@sprints = Sprint.where(project_id: current_user.activeproject_id).order(:start)
    	@stories = Story.where(project_id: current_user.activeproject_id)
    	@selected_velocity = Hash.new # vbistvu rabmo se neki za stet, to ni prov
    	# fora je, da je to vsota timeestimatov vseh zgodb, ki so ble
    	# kadarkol assignane za ta sprint!
    	# se prav rabmo povezavo Sprint -> vec zgodb, zgodba -> vec sprintih

    	@realized_velocity = Hash.new # je OK, ker se steje za tiste, ki so koncane
    	@work_input = Hash.new # ista fora k pr selected...
    	# sam da mormo pr taskih se dt da steje vse ure...
    	@sprints.each do |sprint|
        @start_lst.append(sprint.start)
    		@selected_velocity[sprint.id] = 0
    		@realized_velocity[sprint.id] = 0
    		@work_input[sprint.id] = 0
    	end
    	@stories.each do |story|
    		#@selected_velocity[story.sprint_id]+=story.timeestimates

    		@tasks = Task.all.where(:story_id => story.id)

    		@tasks.each do |task|
    			@work_input[story.sprint_id]+=task.time_estimation
    		end
    	end 

    	@finished_stories = Story.all.where(:finished => true)
    	@finished_stories.each do |finished|
    		@realized_velocity[finished.sprint_id]+=timeestimates

    		
      end

      #BURNDOWN==================================================================================

      sprints = Sprint.where(project_id: current_user.activeproject_id).order(:start)
      starts = sprints.first.start
      ends = sprints.last.end

      sprints_lst = []
      sprints_ids = []
      sprints.each do |s|
          sprints_lst.push(s.start, s.end)
          sprints_ids << s.id
      end

      @y_axis = []
      @x_axis = []
      in_sprint = false
      i = 0
      j = 0
      d = 1
      last = 0
      sprint_estimated = 0
      worktimes_for_sprint = 0
      sprint_constant_time = 0
      starts.upto(ends) do |day|
          if day == sprints_lst[i] && (i % 2 == 0)    #start of sprint
              in_sprint = true
              sprint_estimated = History.select("sum(estimation) as n").where(sprint_id: sprints_ids[j]).first
              worktimes_for_sprint = Worktime.select("day as day, sum(remaining)-sum(task_estimation) as remaining").where(sprint_id: sprints_ids[j]).group(:day)
              story_ids = Worktime.select("distinct story_id").where(sprint_id: sprints_ids[j])

              stories_lst = []
              story_ids.each do |s|
                  stories_lst << s.story_id
              end

              sprint_by_stories = History.select("sum(estimation) as n").where.not(story_id: stories_lst).where(sprint_id: sprints_ids[j]).first
              sprint_by_stories = sprint_by_stories.n * 6

              sprint_by_stories_with_tasks = Worktime.select("sum(task_estimation) as n").where(sprint_id: sprints_ids[j]).first
              divide = Worktime.select("distinct task_id").where(sprint_id: sprints_ids[j]).length
###########################################################################
###########################################################################
              if sprint_by_stories_with_tasks
                  sprint_by_stories_with_tasks = 0
              else
                  sprint_by_stories_with_tasks = sprint_by_stories_with_tasks.n / divide
              end

              sprint_constant_time = sprint_by_stories + sprint_by_stories_with_tasks
              i += 1
              j += 1
              @y_axis.push({ marker: { fillColor: '#FF0000',lineWidth: 3,lineColor: '#FF0000'},y: sprint_estimated.n })
              @x_axis.push("Sprint" + j.to_s)
              huh = true
              worktimes_for_sprint.each do |w|
                  if w.day == day
                      @y_axis.push(sprint_constant_time + w.remaining)
                      huh = false
                  end
              end

              if huh
                @y_axis.push(sprint_constant_time)
              end
          elsif day == sprints_lst[i]                 #end of sprint
              in_sprint = false
              @x_axis.push(d)
              d += 1
              i += 1
              huh = true
              worktimes_for_sprint.each do |w|
                if w.day == day
                  @y_axis.push(sprint_constant_time + w.remaining)
                  last = sprint_constant_time + w.remaining
                  huh = false
                end
                if huh
                  @y_axis.push(sprint_constant_time)
                  last = sprint_constant_time + w.remaining
                end
              end


          else                                        #between two sprints OR inside sprint
              if in_sprint
                  worktimes_for_sprint.each do |w|
                    if w.day == day
                      @y_axis.push(sprint_constant_time + w.remaining)
                      huh = false
                    end
                  end

                  if huh
                    @y_axis.push(sprint_constant_time)
                  end
              else
                 @y_axis.push(last)
              end
              @x_axis.push(d)
              d += 1
          end
      end
      #BURNDOWN==================================================================================

    end

    private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
end