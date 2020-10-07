class ApplicationController < ActionController::Base
	def after_sign_in_path_for(resource)
    posts_path
  end
    def after_sign_out_path_for(resource)
    root_path
    end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :nickname])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:nickname])
  end
end
