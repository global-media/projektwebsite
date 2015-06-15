class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authorize, :except => [:login, :logout, :authenticate, :help, :register, :signup]
  
  
  protected
    
    def authorize
      if !logged_in?
        redirect_to controller: 'admin', action: 'login' and return
      end
    end
      
    def logged_in?
      !session[:user].blank?
    end
end
