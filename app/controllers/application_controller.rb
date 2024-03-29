class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def set_locale
    if params[:locale].present?
      I18n.locale = I18n.available_locales.collect(&:to_s).include?(params[:locale]) ? params[:locale] : I18n.default_locale
    end
  end
end