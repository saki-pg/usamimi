# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :handle_deleted_user, only: [:create]

    # ログイン成功時のリダイレクト先を指定
    def after_sign_in_path_for(_resource)
      root_path
    end

    def create
      self.resource = warden.authenticate!(auth_options)
      if resource
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        respond_with resource, location: after_sign_in_path_for(resource)
      else
        # ログイン失敗時のリダイレクト先を指定
        redirect_to new_user_session_path, alert: 'Invalid login credentials'
      end
    end

    # ゲストユーザーとしてログインするためのメソッドです。
    def guest_sign_in
      user = User.guest
      sign_in user
      redirect_to root_path, notice: t('sessions.guest_user_sign_in')
    end

    protected

    # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
    def handle_deleted_user
      @user = User.find_by(name: params[:user][:name])
      if @user&.valid_password?(params[:user][:password])
        reject_deleted_user
      elsif @user
        flash[:notice] = t('sessions.reject_user.incorrect_input')
      end
    end

    private

    def reject_deleted_user
      return if @user.is_deleted

      flash[:notice] = t('sessions.reject_user.deactivated_account')
      redirect_to new_user_registration_path
    end
  end
end
