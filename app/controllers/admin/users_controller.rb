module Admin
  class UsersController < ApplicationController
    before_action :require_login
    before_action :set_user, only: [:edit, :update]

    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    def index
      @users = policy_scope([:admin, User]).order(:name)
      authorize [:admin, User]
    end

    def edit
      authorize [:admin, @user]
    end

  def update
    authorize [:admin, @user]
    
    # Handle password change if provided
    if user_params[:password].present?
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "Benutzer und Passwort erfolgreich aktualisiert"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      # Update without password
      if @user.update(user_params.except(:password, :password_confirmation))
        redirect_to admin_users_path, notice: "Benutzer erfolgreich aktualisiert"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
    end
  end
end
