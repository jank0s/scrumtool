class SessionsController < ApplicationController

  	def create
	    user = User.find_by(username: params[:session][:username].downcase)
	    if user && user.authenticate(params[:session][:password])
	    	sign_in user
	    	redirect_to root_url
	    else
	    	redirect_to root_url
	    end
  	end

  	def new
  	end

  	def destroy
		sign_out
    	redirect_to root_url
	end
end