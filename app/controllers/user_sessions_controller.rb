class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Log in successful"
      redirect_to home_path
    else
      flash[:error] = "Invalid Login"
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy

    flash[:notice] = "Log out successful"
    redirect_to home_path
  end
end
