class ArticlesController < ApplicationController
  def index
    @articles = Article.order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to home_index_url(tab:"documentation"), notice: "The documentation has been successfully created."
    else
      render action: "index"
    end
  end

  def edit
    @article = Article.find(params[:id])
    @articles = Article.order("created_at DESC")
    @stories = Story.order("created_at ASC")
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      redirect_to home_index_url(tab:"documentation"), notice: "The documentation has been successfully updated."
    else
      render action: "edit"
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    redirect_to home_index_url(tab:"documentation"), notice: "The documentation has been successfully deleted."
  end

  def edit_documentation
    @article=Article.find(params[:id])
    if !params[:story_ids].nil?
      @stories = Story.find(params[:story_ids])
      @conditions = params[:conditions]
      @bottomtop = params[:bottomtop]

      if @bottomtop[7]=="b"
        @stories.each do |story|
          if !@conditions[0].nil?
            @article.body = @article.body + "<p><span style='font-size:24px'><span style='color:#008000'>" + story.name + "</span></p>"
          end
          if !@conditions[1].nil?
            @article.body = @article.body + "<p><strong>" + story.description + "</strong></p>"
          end
          if !@conditions[2].nil?
            if !story.test.nil?
              @article.body = @article.body + "<p>" + story.test + "</p>"
            end
          end
          if !@conditions[3].nil?
              if !story.note.nil?
                @article.body = @article.body + "<p>" + story.note + "</p>"
              end
          end
        end
      else
        @stories.each do |story|
          if !@conditions[3].nil?
            if !story.note.nil?
              @article.body = "<p>" + story.note + "</p>" + @article.body
            end
          end
          if !@conditions[2].nil?
            if !story.test.nil?
              @article.body = "<p>" + story.test + "</p>" + @article.body
            end
          end
          if !@conditions[1].nil?
            @article.body =  "<p><strong>" + story.description + "</strong></p>" + @article.body
          end
          if !@conditions[0].nil?
            @article.body = "<p><span style='font-size:24px'><span style='color:#008000'>" + story.name + "</span></p>" + @article.body
          end
        end
      end
      @article.save
      redirect_to edit_article_path(@article), notice: "Stories added."
    else
      redirect_to edit_article_path(@article), notice: "You haven't specified any stories to add."
    end
  end

  private

  def article_params
    params.require(:article).permit(:body)
  end
end