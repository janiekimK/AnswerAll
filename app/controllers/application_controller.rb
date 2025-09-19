class ApplicationController < ActionController::Base
  include Pundit::Authorization

  helper_method :current_user, :logged_in?

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "Nicht berechtigt."
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to new_session_path, alert: "Bitte zuerst einloggen"
    end
  end
end
