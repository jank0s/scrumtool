class StoriesController < ApplicationController
    before_action :signed_in_user
    before_action :correct_user
    before_action :po_or_sm, only: [:new, :create, :destroy]
    before_action :po, only: [:accept, :reject]

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
            @sprintStories=@stories.where(finished: false, sprint_id: @current_sprint)
        end
        @remainingStories=@stories.where(finished: false, sprint_id: nil)
        #@finishedStories=@stories.where(finished: true)
        @finishedStories = Story.where(project_id: current_user.activeproject_id, finished: true)
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
            ok = []
            nok =[]
            @storyids.each do |s|
                @storytoadd = Story.find_by(id: s)
                if (@timeestimate[i].to_f > 0.0 && @timeestimate[i].to_f < 100.0)
                    @storytoadd = Story.find_by(id: s)
                    @storytoadd.update_attributes(timeestimates: @timeestimate[i].to_f)
                    ok.push @storytoadd.name
                elsif (@timeestimate[i].to_f > 100.0)
                    nok.push @storytoadd.name
                elsif (@timeestimate[i].size != 0)
                    nok.push @storytoadd.name
                elsif (@timeestimate[i].size == 0)
                    @storytoadd.update_attributes(:timeestimates => nil)
                    ok.push @storytoadd.name
                end
                i+=1
            end
            if (!ok.empty?)
                flash[:success] = "Time is set for "+ok.map(&:inspect).join(', ')+"."
            end
            if (!nok.empty?)
                flash[:warning] = "Time cannot be set for "+nok.map(&:inspect).join(', ')+"."
            end

            #=================================================================================================================
            #*****************************************************************************************************************
            #stories_time_sum = Story.select("sum(timeestimates) as n").where(project_id: current_user.activeproject_id).first
            #stories_time_sum = stories_time_sum.n

            sprint_id = currently_running_sprint
            stories = Story.where(finished: false, project_id: current_user.activeproject_id)

            if sprint_id == -1
                future_sprint = Sprint.where("start > ?", Date.today).order(:start).first
                if future_sprint == nil
                    flash[:warning] = "First create new sprint"
                else
                    History.delete_all(sprint_id: future_sprint.id)
                    stories.each do |s|
                        History.create(story_id: s.id, sprint_id: future_sprint.id, estimation: s.timeestimates,
                                       project_id: current_user.activeproject_id)
                    end
                end
            else
                History.delete_all(sprint_id: sprint_id)
                stories.each do |s|
                  History.create(story_id: s.id, sprint_id: sprint_id, estimation: s.timeestimates,
                                 project_id: current_user.activeproject_id)
                end
            end
            #*****************************************************************************************************************
            #=================================================================================================================


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

                        end
                    end
                end
            end
           
        end
      redirect_to stories_url
    end

    def accept
        @story=Story.find(params[:id])
        @story.finished=true
        @story.finished_in_sprint = currently_running_sprint
        if @story.save
            redirect_to stories_url
        else
            flash[:danger] = @story.errors.messages[:base].first
            redirect_to stories_url
        end

    end

    def reject
        @story=Story.find(params[:id])
        @story.note=params[:value]
        @story.sprint=nil
        @story.save
        redirect_to stories_url
    end

    def notes
        @story=Story.find(params[:id])
        @story.note=params[:value]
        @story.save
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

    def po
        redirect_to root_url unless (productowner? || admin?)
    end
end
