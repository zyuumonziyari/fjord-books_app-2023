# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_account_update_params, only: [:update]
    
    protected
    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || users_path
    end 

    def after_sign_out_path_for(scope)
      stored_location_for(scope) || new_user_session_path
    end

    def configure_account_update_params
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_text, :addrss, :post_number])
    end

end
