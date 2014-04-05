class StoriesController < ApplicationController
    def index
    end

    def new
        @story = Story.new
    end
end
