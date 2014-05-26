class ProgressController < ApplicationController
    before_action :signed_in_user

    def index
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


      @lst = []
      @start = @sprints.first.start
      @end = Date.today
      @days = (@end - @start).to_i

      @work_sum = 0
      @task_lst = []
      @kst = []
      @stories.each do |story|
        tasks_by_story = story.tasks

        if tasks_by_story.length != 0
          tasks_by_story.each do |task|

          @task_lst.append(task.id)

            @worktimes = Worktime.where(task_id: task.id).order(:day)
            if @worktimes.length != 0
              testdate = Date.today
              if @worktimes.last.day < testdate   # SPRAVT V HASH, DA VSE NAENKRAT ZAPISE
                @r = @worktimes.last.remaining
                x = (testdate - @worktimes.last.day).to_i

                for i in 1..x
                  Worktime.create(done: 0, remaining: @r, day: @worktimes.last.day + i.days, task_id: task.id,
                                  task_estimation: task.time_estimation)
                end
              end
            end

            @work_sum += task.time_estimation
            @kst.append(task.time_estimation)
          end
        else
          @work_sum += (story.timeestimates * 6)
          @kst.append(story.timeestimates * 6)
        end

      end

      @hihi = Worktime.where(:task_id => @task_lst)
      puts @hihi
      @haha = Worktime.select("day as day, sum(remaining)-sum(task_estimation) as remaining").group("day").order("day")



      for i in 0..(@days-1)
        @lst.push(@work_sum + @haha[i].remaining)
      end


      #BURNDOWN==================================================================================


    end

    private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
end