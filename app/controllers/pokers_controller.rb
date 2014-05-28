class PokersController < ApplicationController
	before_action :signed_in_user
    before_action :correct_user

	def index
		@rstories=current_user.activeproject.stories
		@stories=@rstories.where(finished: false, sprint_id: nil)
    end
    def new
    	a = params[:story]
    	
    	if !a.nil?
    		@story_id = a[:story_id]
    		cookies[:story_id] = @story_id
    	end
    	if a.nil?
    		@story_id = cookies[:story_id]
    	end
    	@story = Story.find(@story_id)
    	@poker = Poker.find_by(story_id: @story_id)
    	if @poker.nil?
	    	@poker = Poker.new(active: true, story_id: @story_id)
        	@poker.save
       	end
        @round = Round.find_by(poker_id: @poker.id, active: true)
   	end

   	def startgame
   		@story_id = cookies[:story_id]
   		@poker = Poker.find_by(story_id: @story_id)
   		@round = Round.new(active: true, poker_id:@poker.id)
   		@round.save
   		# make new Round, write it in cookie
   		redirect_to :back
   	end

   	def endgame
   		@story_id = cookies[:story_id]
   		@poker = Poker.find_by(story_id: @story_id)
   		@round = Round.find_by(poker_id: @poker.id, active: true)
   		@round.update_attributes(:active => false)
   		redirect_to :back
   	end

   	private

    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
    def correct_user
        redirect_to root_url unless current_user.activeproject!=nil
    end
end
