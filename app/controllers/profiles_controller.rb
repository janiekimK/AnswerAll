class ProfilesController < ApplicationController
  before_action :require_login

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    unless @user.authenticate(params.dig(:user, :current_password).to_s)
      @user.errors.add(:current_password, "ist falsch")
      return render :edit, status: :unprocessable_entity
    end

    User.transaction do
      if params[:user][:email].present? && params[:user][:email] != @user.email
        @user.unconfirmed_email = params[:user][:email]
        @user.confirmation_token = SecureRandom.hex(16)
      end

      updates = { name: params[:user][:name] }
      if params[:user][:password].present?
        updates[:password] = params[:user][:password]
        updates[:password_confirmation] = params[:user][:password_confirmation]
      end

      if @user.update(updates)
        if @user.unconfirmed_email.present?
          confirmation_link = "http://localhost:3000/confirm_email?token=#{@user.confirmation_token}"
          Rails.logger.debug "Email confirmation link: #{confirmation_link}"
        end
        redirect_to profile_path, notice: "Profil erfolgreich aktualisiert"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def confirm_email
    token = params[:token].to_s
    @user = current_user

    if token.present? && @user&.confirmation_token == token && @user.unconfirmed_email.present?
      @user.update!(email: @user.unconfirmed_email, unconfirmed_email: nil, confirmation_token: nil)
      redirect_to profile_path, notice: "E-Mail-Adresse bestätigt"
    else
      redirect_to profile_path, alert: "Ungültiger oder abgelaufener Bestätigungslink"
    end
  end
end
