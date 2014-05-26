class ArticlesController < ApplicationController
  def index
    @articles = Article.order("created_at DESC")
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to home_index_url(tab:"documentation"), notice: "The documentation has been successfully created."
    else
      render action: "new"
    end
  end

  def edit
    @article = Article.find(params[:id])
    @articles = Article.order("created_at DESC")
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

  def notes
    @article=Article.find(params[:id])
    @article.body=params[:value]
    @article.save
    redirect_to home_index_url(tab:"documentation")
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end