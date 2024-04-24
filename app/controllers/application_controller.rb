# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_account_update_params, if: :devise_controller?

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || users_path
  end

  def after_sign_out_path_for(_resource_name)
    new_user_session_path
  end

  def configure_account_update_params
    keys = %i[name self_introduction address postal_code]
    devise_parameter_sanitizer.permit(:account_update, keys:)
  end
end
