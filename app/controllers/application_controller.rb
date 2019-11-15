class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_account_update_params, if: :devise_controller?
  before_action :configure_sign_up_params, if: :devise_controller?

  protected

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
