class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authorize, except: [:login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset]
  
  before_filter :validate_permission, except: [:profile, :login, :logout, :authenticate, :help, :register, :registration, :forgot, :reset]
  
  protected
    
    def user_params
      params.require(:user).permit!
    end
  
    def authorize
      if !logged_in?
        redirect_to action_admin_url(action: 'login') and return
      end
    end
      
    def logged_in?
      !session[:user].blank?
    end
    
    def validate_permission
      return false unless logged_in?
      paths = request.path.split('/')[1..-1]
      
      if role = User.find(session[:user]['id']).role
        return true if role.permissions == 'all'
        while(true)
          break unless route_path = paths.delete_at(0)
          return true if role.permissions.split(',').detect {|perm| perm.strip == route_path}
        end unless role.permissions.blank?
      end
      
      redirect_to admin_dashboards_url and return false unless request.path == '/admin/dashboards'
    end
    # helper_method :validate_permission
end
