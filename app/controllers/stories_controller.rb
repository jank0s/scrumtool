class StoriesController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user
    before_action :po_or_sm, only: [:new, :create, :destroy]

    def index
        @stories=current_user.activeproject.stories
        @sprintStories=[]
        @remainingStories=@stories.where(finished: false)
        @finishedStories=@stories.where(finished: true)
    end

    def new
        @story = Story.new
    end

    def create
        @story = Story.new(story_params)
        @story.project=current_user.activeproject
        @story.finished=false
        if @story.save
            redirect_to stories_url
        else
            render "new"
        end
    end

    def edit
        @story = Story.find(params[:id])
    end

    def update
        @story = Story.find(params[:id])
        @story.project=current_user.activeproject
        @story.finished=false
        if @story.update_attributes(story_params)
            redirect_to stories_url
        else
            render 'edit'
        end
    end

    def destroy
        Story.find(params[:id]).destroy
        redirect_to stories_url
    end

    def addtosprint
        @stories=current_user.activeproject.stories
        @remainingStories=@stories.where(finished: false)

        if params[:timeestimates] 
            @timeestimate = params[:timeestimate]
            i=0
            assigned=0
            @remainingStories.each do |s|
                @tasks = s.tasks
                @tasks.each do |t|
                    if (t.assigned_to != nil)
                        assigned=1
                    end
                end
                if (assigned ==1)
                    break
                end
                if (@timeestimate[i].size > 0)
                    puts s.timeestimates
                    s.update_attributes(timeestimates: @timeestimate[i])
                end
                i=i+1
            end
        elsif params[:addtosprint] 
            @addto = params[:story_id].map(&:to_i)
            i=0
            @remainingStories.each do |s|
                if (s.timeestimates != nil && s.finished==false && @addto.include?(s.id))
                    #sprint_running?(sprint)
                    #s.sprint_id = 
                    # set sprint_id = id od current sprinta
                    
                end
            end
        end
      redirect_to stories_url
    end

    private
    def story_params
        params.require(:story).permit(:name, :description, :test, :priority_id, :value)
    end

    def signed_in_user
        redirect_to signin_url unless signed_in?
    end

    def correct_user
        redirect_to root_url unless current_user.activeproject!=nil
    end

    def po_or_sm
        redirect_to root_url unless (productowner? || scrummaster? || admin?)
    end
end
