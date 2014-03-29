class SprintsController < ApplicationController

  def index
    @sprints = Sprint.all
  end
end
