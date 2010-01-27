class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    
    if User.exists?(:email => params[:user][:email])
      @user = UserSession.new(params[:user])
    else
      @user = User.new(params[:user])
    end
    
    if @user.save
      flash[:notice] = "Login successful!"
      redirect_to_target_or_default root_url
    else
      flash[:error] = "You have an invalid email/password combination."
      render :action => :new
    end

  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to_target_or_default root_url
  end
  
end
