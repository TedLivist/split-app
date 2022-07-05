class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_paramters, if: :devise_controller?

  def clear_session_variables
    session[:errors], session[:expense_amount], session[:debtors], session[:expense_id] = nil, nil, nil, nil
  end

  def check_session_variables
    if session[:errors].nil? and session[:expense_amount].nil? and session[:debtors].nil? and session[:expense_id].nil?
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_paramters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
