class ApplicationController < ActionController::Base
  def after_sign_in_path_for(_resource)
    posts_path
  end

  def after_sign_out_path_for(_resource)
    root_path
  end

  add_flash_types :success, :warning

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[last_name first_name nickname email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:nickname])
  end
end
