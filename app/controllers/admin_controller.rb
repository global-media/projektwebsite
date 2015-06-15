class AdminController < ApplicationController
  layout 'admin'
  
  def index
    if logged_in?
      redirect_to controller: 'pages'
    else
      redirect_to action: 'login'
    end
  end
  
  def login
  end
  
  def logout
    session[:user] = nil
    redirect_to controller: 'admin'
  end
  
  def signup
  end
  
  def register
    user = User.new(user_params)
    if user.save
      session[:user] = user
      flash[:success] = 'Login success!'
      redirect_to controller: 'pages' and return
    end
    flash[:error] = "We're sorry but we cannot sign up at the moment"
    redirect_to action: 'signup' and return
  end
  
  def authenticate
    if user = User.verify?(params[:user][:email_username], params[:user][:password])
      session[:user] = user
      flash[:success] = 'Login success!'
      redirect_to controller: 'pages' and return 
    end
    
    flash[:error] = "We're sorry but your login information is invalid"
    redirect_to action: 'login' and return
  end
  
  def profile
    @user = User.find(session[:user]['id'])
    render layout: 'pages'
  end
  
  def update_profile
    user = User.find(user_params[:id])
    if user.update_attributes(user_params)
      flash[:success] = 'Profile Update success!'
      redirect_to action: 'profile' and return
    end
    flash[:error] = "We're sorry, we cannot update your profile at the moment"
    render template: 'profile'
  end
  
  protected

    def user_params
      params.require(:user).permit!
    end
end
