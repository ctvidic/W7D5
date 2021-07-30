class UsersController < ApplicationController
    before_action :ensure_logged_in, only: [:show, :index, :create, :update, :destroy]
    before_action :ensure_logged_out, only: [:new, :create]

    def new 
        @user = User.new 
        render :new 
    end 

    def show
        @user = User.find(params[:id])
        render :show 
    end 

    def index 
        @users = User.all 
        render :index 
    end 

    def edit  
        render :edit 
    end 

    def create 
        @user = User.new(user_params)
        if @user.save 
            login(@user)
            redirect_to users_url 
        else  
            flash.now[:errors] = @user.errors.full_messages  
            render :new 
        end 
    end 

    def update 
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to user_url(@user)
        else  
            flash.now[:errors] = @user.errors.full_messages 
            render :edit 
        end 
    end 

    def destroy 
        @user = User.find(params[:id])
        @user.destroy 
        redirect_to new_session_url
    end 

    private 

    def user_params 
        params.require(:user).permit(:username, :password)
    end 

end 