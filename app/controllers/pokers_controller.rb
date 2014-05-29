class PokersController < ApplicationController
	before_action :signed_in_user
    before_action :correct_user

	def index
		@rstories=current_user.activeproject.stories
		@stories=@rstories.where(finished: false, sprint_id: nil)
		@running_poker = Poker.where(active: true, :story_id=>@stories)
		if !@running_poker.empty?
			redirect_to new_poker_path
		end
    end
    def new
    	@rstories=current_user.activeproject.stories
		@stories=@rstories.where(finished: false, sprint_id: nil)
		
    	a = params[:story]
    	if !a.nil?
    		@story_id = a[:story_id]
    		@poker = Poker.find_by(story_id: @story_id)
    		if @poker.nil?
	    		@poker = Poker.new(active: true, story_id: @story_id)
    			@poker.save
       		end
       	else
       		@poker = Poker.where(active: true, :story_id=>@stories).first
       		if @poker.nil?
    			return redirect_to pokers_path
       		end
	       	@story_id = @poker.story_id
    		
    	end

    	@story = Story.find(@story_id)
    	puts @story_id

        @round = Round.find_by(poker_id: @poker.id, active: true)
        @rounds_inactive = Round.where(poker_id: @poker.id, active: false)
        @rounds_inactive_id = Round.select(:id).where(poker_id: @poker.id, active: false)
        @round_all = Round.select(:id).where(poker_id: @poker.id)

        @pokercards = Array.new
        @pokercards = [0, 0.5, 1, 1.5, 2, 3, 5, 8, 13, 20, 40, "Pass", "Custom"]

    	@users = Project.find(current_user.activeproject_id).users
    	@ids = []
    	
    	@idusersfromentries = Round.where(poker_id: @poker.id).joins(:entries).select("entries.user_id").uniq

    	@idusersfromentries.each do |u|
    		@ids.push(u.user_id)
    	end
    	# ids contains all the ids from users which have been on the past rounds...
    	@ids = @ids.sort

    	@roundhash = Hash.new

    	@round_all.each do |r|
    		innerhash = Hash.new
    		@ids.each do |u|
    			e = Entry.where(round_id: r.id, user_id: u).first
    			if e.nil?
    				innerhash[u] = nil
    			else
	    			innerhash[u] = e.value
    			end
    		end
    		@roundhash[r.id] = innerhash
    	end	
    	@curr_round = Round.where(poker_id: @poker.id, active: true).select("id").first
    	@has_voted = Entry.where(round_id: @curr_round, user_id: current_user.id)
    	if !@curr_round.nil?
    		@curr_round = @curr_round.id
    	end

   	end

   	def startgame
   		@rstories=current_user.activeproject.stories
		@stories=@rstories.where(finished: false, sprint_id: nil)
		@poker = Poker.where(active: true, :story_id=>@stories).first
       	@story_id = @poker.story_id

   		@poker = Poker.find_by(story_id: @story_id)
   		@round = Round.new(active: true, poker_id: @poker.id)
   		@round.save
   		redirect_to :back
   	end

   	def endgame
   		@rstories=current_user.activeproject.stories
		@stories=@rstories.where(finished: false, sprint_id: nil)
		@poker = Poker.where(active: true, :story_id=>@stories).first
       	@story_id = @poker.story_id

   		@poker = Poker.find_by(story_id: @story_id)
   		@round = Round.find_by(poker_id: @poker.id, active: true)
   		@round.update_attributes(:active => false)
   		redirect_to :back
   	end

   	def makeentry
   		value = params[:entry]
   		# ce je value cifra, dej v entry 
   		@rstories=current_user.activeproject.stories
		@stories=@rstories.where(finished: false, sprint_id: nil)
		@poker = Poker.where(active: true, :story_id=>@stories).first
       	@story_id = @poker.story_id

   		@poker = Poker.find_by(story_id: @story_id)
   		@round = Round.find_by(poker_id: @poker.id, active: true)
   		if value.to_s == "Pass"
   			@entry = Entry.new(user_id: current_user.id, round_id: @round.id, value: nil)
   			@entry.save
   		elsif value.to_i
   			@entry = Entry.new(user_id: current_user.id, round_id: @round.id, value: value.to_f)
   			@entry.save
   		end

   		## ce custom pop up -> enter value....

   		redirect_to :back
   	end

   	def cancel
   		@rstories=current_user.activeproject.stories
		@stories=@rstories.where(finished: false, sprint_id: nil)
		@poker = Poker.where(active: true, :story_id=>@stories).first
       	@story_id = @poker.story_id

   		@running_poker = Poker.where(active: true, :story_id=>@story_id).first
   		@running_poker.update_attributes(:active => false)
   		return redirect_to pokers_path

   	end

   	def savetime
   		# ce se ni nobenga value vstavis prejsni average !!!!
   		@time = params[:time]
   		@rstories=current_user.activeproject.stories
		@stories=@rstories.where(finished: false, sprint_id: nil)
		@poker = Poker.where(active: true, :story_id=>@stories).first
		@poker.update_attributes(:active => false)
       	@story_id = @poker.story_id

   		@story = Story.find_by(id: @story_id)
   		@story.update_attributes(:timeestimates => @time)
   		return redirect_to pokers_path

   	end
   	private

    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
    def correct_user
        redirect_to root_url unless current_user.activeproject!=nil
    end
end
