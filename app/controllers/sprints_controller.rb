class SprintsController < ApplicationController

  def index
    @sprints = Sprint.all
  end

  def new
    @sprint = Sprint.new
  end

  def create
    @sprint = Sprint.new(sprint_params)

    if @sprint.save
      redirect_to sprints_url
    else
      render "new"
    end
  end

  private
  def sprint_params
    params.require(:sprint).permit(:number, :start, :end, :velocity)
  end
end
