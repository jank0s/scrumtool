class TasksController < ApplicationController


  def index
    @tasks = Task.where(story_id: 1)  # 1 for testing
  end

  def new

  end

end
