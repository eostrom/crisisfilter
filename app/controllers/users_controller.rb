class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      session[:user_id] = @user.id
      add_auth_token if params[:remember_me] == "1"
      flash[:notice] = "Logged in successfully."
      redirect_to_target_or_default(root_url)
    else
      flash.now[:error] = "Invalid email or password."
      render :action => 'new'
    end
  end

  def destroy
    current_user.forget_me if logged_in?
    cookies.delete :auth_token
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end

private
  
  def add_auth_token
    current_user.remember_me
    cookies[:auth_token] = { :value   => current_user.remember_token,
                             :expires => current_user.remember_token_expires_at }
  end
  
end
