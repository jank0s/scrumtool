class SessionsController < ApplicationController

  	def create
	    user = User.find_by(username: params[:session][:username].downcase)
	    if user && user.active && user.authenticate(params[:session][:password])
	    	sign_in user
	    	flash[:success] = "Welcome to TPO11 - Scrum"
	    	redirect_to root_url
	    else
	    	flash[:danger] = "Wrong credentials"
	    	redirect_to root_url
	    end
  	end

  	def new
  	end

  	def destroy
		sign_out
		flash[:warning] = "Bye"
    	redirect_to root_url
	end
end