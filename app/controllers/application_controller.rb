class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    extra_params = [ :is_admin, :is_premium ]
    devise_parameter_sanitizer.permit(:sign_up, keys: extra_params)
  end

  def admin_required
    if !current_user.is_admin?
      redirect_to "/"
    end
  end
end
