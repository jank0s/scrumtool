class UsersController < ApplicationController
    before_action :signed_in_user, only: [:index, :show, :new, :create]
    before_action :correct_user, only: [:show, :edit, :update]
    before_action :admin_user, only: [:index, :new, :create]

    def index
        @users=User.all
    end

    def show

    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            redirect_to users_url
        else
            render 'edit'
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to users_url
        else
            render "new"
        end
    end

    private
    def user_params
        if admin?
            params.require(:user).permit(:username, :password, :password_confirmation, :email, :name, :surname, :role_id)
        else
            params.require(:user).permit(:username, :password, :password_confirmation, :email, :name, :surname)
        end

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
