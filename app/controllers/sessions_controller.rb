class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => 'Logare cu succes'
    else
      
    end
  end

  def destroy
  end
end
