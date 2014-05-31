class HomeController < ApplicationController
    before_action :signed_in_user, only: [:index]

    def index
        @user=current_user
        @projects=(@user.projects+@user.productowner_projects+@user.scrummaster_projects).uniq
        @post=Post.new
        @articles=Article.order("created_at DESC")
        if @articles.size==0
          @article=Article.new
          @article.body=""
          #@article.title=current_user.activeproject_id
          @article.save
        end

        @comment = Comment.new
        @posts=Post.where(project_id: current_user.activeproject_id).order("created_at DESC").all
        @comments = Comment.where(project_id: current_user.activeproject_id).order("created_at DESC").all
        @users=Teammember.where(project_id: current_user.activeproject_id)
    end

    

    private
    def signed_in_user
        redirect_to signin_url unless signed_in?
    end
end
