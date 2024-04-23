# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || users_path
  end

  def after_sign_out_path_for(scope)
    new_user_session_path
  end
end
