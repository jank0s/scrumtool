class SprintsController < ApplicationController

  def index
    @sprints = Sprint.where(project_id: current_user.activeproject_id).order(:start)
  end

  def new
    @sprint = Sprint.new
  end

  def create
    @sprint = Sprint.new(sprint_params)

    @sprint.project_id = current_user.activeproject_id

    if @sprint.save
      redirect_to sprints_url
    else
      render "new"
    end
  end

  def edit
    @sprint = Sprint.find(params[:id])
  end

  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  def update
    @sprint = Sprint.find(params[:id])
    if @sprint.update_attributes(sprint_params)
      redirect_to sprints_url
    else
      render 'edit'
    end
  end
  # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  def destroy
    Sprint.find(params[:id]).destroy
    redirect_to sprints_url
  end

  private
  def sprint_params
    params.require(:sprint).permit(:number, :start, :end, :velocity)
  end
end
