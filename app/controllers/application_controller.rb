class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :get_current_season
  
  protected
  
  def check_for_admin
    if !user_signed_in?
      flash[:error] = 'You are not allowed to do this.'
      redirect_to '/' and return
    elsif !current_user.is_admin? 
      flash[:error] = 'You are not allowed to do this.'
      redirect_to '/' and return
    end
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_token, :is_admin,  :remember_created_at, :sign_in_count) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :display_name, :is_admin, :password_confirmation) }
  end
  
  def get_current_season
    @current_season = Season.last
  end
  

end
