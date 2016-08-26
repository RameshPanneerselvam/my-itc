class SessionsController < ApplicationController
  def new
        session[:user_id] = nil
  end

  def create

    user = User.where(:user_name=>params[:user_name], :password=>params[:password][0])
    unless user.empty?
      session[:user_id] = user[0].id
      $user_id=user[0].id
      redirect_to users_user_dashboard_path, :notice => "Logged in!"
    else
#      render "new"
      redirect_to root_url
      flash[:notice]= "Invalid username or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

end
