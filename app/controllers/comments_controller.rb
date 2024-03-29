class CommentsController < ApplicationController
	before_action :signed_in_user, only: [:index]

	def create
    @comment = Comment.new(comment_params)
    
    @comment.project_id = current_user.activeproject_id
    @comment.user_id = current_user.id
    #ne shran post_idja
    @comment.post_id
    if @comment.save
      redirect_to home_index_url(tab:"discussion")
	else
      render "index"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to home_index_url(tab:"discussion")
  end

  def comment_params
    params.require(:comment).permit(:value, :post_id)
  end



	private
  	def signed_in_user
    	redirect_to signin_url unless signed_in?
  	end
end
