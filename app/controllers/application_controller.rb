class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def welcome_dashboards
    if user_signed_in?
      redirect_to root_path
    else
      redirect_to welcome_hi_path
    end
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
    end

    def current_user?(user)
      current_user.id == user.id
    end

    helper_method :current_user?


  #  def authenticate_user!
  #    if user_signed_in?
  #      super
  #    else
  #      redirect_to welcome_hi_url, alert: "¡Primero loggeate! :)"
  #    end
  #  end
end