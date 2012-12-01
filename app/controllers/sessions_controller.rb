class SessionsController < ApplicationController
  def new
    render 'new'
  end
  
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash.now[:error] = t(:invalid_email_password_combination)
      render 'new'
    end
  end
  
  def destroy
    
  end
end
