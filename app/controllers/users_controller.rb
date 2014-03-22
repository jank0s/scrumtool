class UsersController < ApplicationController
	before_action :signed_in_user, only: [:index, :new]
	#before_action :correct_user, only: []
	before_action :admin_user, only: [:index, :new]

	def index
		@users=User.all
	end

	def show
	end

	def new
	end

	private
    	def user_params
        	params.require(:user).permit(:username, :password, :password_confirmation, :email, :name, :surname)
    	end

    	def signed_in_user
    		redirect_to signin_url unless signed_in?
   		end

   		def correct_user
   			@user = User.find(params[:id])
      		redirect_to root_url unless admin? || current_user?(@user)
   		end

   		def admin_user
   			redirect_to root_url unless admin? 
   		end
end
