class StoriesController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user
    before_action :po_or_sm, only: [:new, :create, :destroy]

    def index
        @stories=current_user.activeproject.stories
        @sprints = Sprint.all
        @current_sprint
        @current_sprint_name
        @sprintStories=[]
        @sprints.each do |sprint|
            if (sprint.end >= Date.today && sprint.start <= Date.today)
                @current_sprint = sprint.id
            end
        end
        if (@current_sprint != nil)
            @current_sprint_name = @sprints.where(id: @current_sprint).name
            @sprintStories=@stories.where(sprint_id: @current_sprint)
        end
        @remainingStories=@stories.where(finished: false, sprint_id: nil)
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
            @storyids = params[:storyid]

            i=0
            @storyids.each do |s|
                if (@timeestimate[i].to_f > 0.0 && @timeestimate[i].to_f < 100.0)
                    @storytoadd = Story.find_by(id: s)
                    @storytoadd.update_attributes(timeestimates: @timeestimate[i].to_f)
                    flash[:success] = "Time estimate is set."
                elsif (@timeestimate[i].to_f > 100.0)
                    flash[:warning] = "Cannot set time estime. Time estimate is bigger than 100.0"
                elsif (@timeestimate[i].size != 0)
                    flash[:warning] = "Cannot set time estime."
                end
                i+=1
            end
        elsif params[:addtosprint] 
            @addto = params[:story_id].map(&:to_i)
            i=0
            @addto.each do |add|
                @storytoadd = Story.find_by(id: add)
                @sprints = Sprint.all
                @sprints.each do |sprint|
                    if (sprint.end >= Date.today && sprint.start <= Date.today)
                        if (@storytoadd.timeestimates != nil)
                            @storytoadd.update_attributes(sprint_id: sprint.id)
                            flash[:success] = "Story added to current sprint."
                        else
                            flash[:warning] = "Cannot add story. Time estimates is not set."
                        end
                    end
                end
            end
        end
      redirect_to stories_url
    end

    def accept
        redirect_to stories_url
    end

    def reject
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
