class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username:params[:session][:username.downcase])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "You are logged in"
            redirect_to user
        else
            flash.now[:alert] = "Invalid Credentials"
            render 'new'
        end
    end

    def destroy
        session[:user_id] = nil
        flash[:alert] = "Logged out"
        redirect_to root_path
    end

end