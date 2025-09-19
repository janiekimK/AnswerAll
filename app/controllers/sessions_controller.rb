class SessionsController < ApplicationController
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
    session.delete(:user_id)
    redirect_to root_path, notice: "Erfolgreich ausgeloggt!"
  end
end
