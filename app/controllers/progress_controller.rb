class ProgressController < ApplicationController
    before_action :signed_in_user

    def index
    	@sprints = Sprint.all
    	@stories = Story.all
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
    		@selected_velocity[story.sprint_id]+=story.timeestimates

    		@tasks = Task.all.where(:story_id => story.id)

    		@tasks.each do |task|
    			@work_input[story.sprint_id]+=task.time_estimation
    		end
    	end 

    	@finished_stories = Story.all.where(:finished => true)
    	@finished_stories.each do |finished|
    		@realized_velocity[finished.sprint_id]+=timeestimates

    		
    	end


    end

    private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
end