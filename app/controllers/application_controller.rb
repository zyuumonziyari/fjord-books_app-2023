# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    
    protected
  
    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || users_path
    end 
end
