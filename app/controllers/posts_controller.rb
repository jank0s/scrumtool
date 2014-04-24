class PostsController < ApplicationController
  before_action :signed_in_user, only: [:index]

  def create
    @post = Post.new(post_params)
    @post.project_id = current_user.activeproject_id
    @post.user_id = current_user.id
    if @post.save
      redirect_to home_index_url
    else
      render "index"
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to home_index_url
  end

  def post_params
    params.require(:post).permit(:value, :topic)
  end

  private
  def signed_in_user
    redirect_to signin_url unless signed_in?
  end
end
