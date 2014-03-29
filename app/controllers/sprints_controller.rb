class SprintsController < ApplicationController

  def index
    @sprints = Sprint.all
  end

  def new
    @sprint = Sprint.new
  end
  
end
