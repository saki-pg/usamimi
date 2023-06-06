# frozen_string_literal: true

# Usersモジュール
module Users
  # DeviseのSessionsControllerを拡張してユーザーのセッション管理を行うクラス
  class SessionsController < Devise::SessionsController
    # ゲストユーザーとしてログインするためのメソッドです。
    def guest_sign_in
      user = User.guest
      sign_in user
      redirect_to root_path, notice: t('sessions.guest_user_sign_in')
    end

    protected

    # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
    def reject_user
      @user = User.find_by(name: params[:user][:name])
      if @user&.valid_password?(params[:user][:password])
        handle_user_rejection
      elsif @user
        flash[:notice] = t('sessions.reject_user.incorrect_input')
      end
    end

    private

    def handle_user_rejection
      return unless @user.is_deleted == false

      flash[:notice] = t('sessions.reject_user.deactivated_account')
      redirect_to new_user_registration_path
    end
  end
end
