class StoriesController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user
    before_action :po_or_sm, only: [:new, :create, :destroy]

    def index
        @stories=current_user.activeproject.stories
        @sprintStories=[]
        @remainingStories=@stories.where(finished: false)
        @finishedStories=@stories.where(finished: true)
        if scrummaster?
            @sm = 1
        else
            @sm = 0
        end
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
