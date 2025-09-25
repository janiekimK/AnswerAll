class SessionsController < ApplicationController
  # Prevent caching of login/logout pages
  before_action :set_no_cache_headers

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Erfolgreich eingeloggt!"
    else
      flash.now[:alert] = "Ungültige E-Mail oder Passwort"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # Clear the entire session to ensure complete logout
    session.clear
    # Reset the session to prevent session fixation attacks
    reset_session
    redirect_to root_path, notice: "Erfolgreich ausgeloggt!"
  end

  private

  def set_no_cache_headers
    # Prevent caching of login/logout pages
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate, private'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
  end
end
