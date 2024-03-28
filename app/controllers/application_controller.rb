# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :current_locale

  def current_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: current_locale }
  end
end
