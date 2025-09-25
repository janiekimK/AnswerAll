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
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "Benutzer aktualisiert"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :role)
    end
  end
end
