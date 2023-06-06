# frozen_string_literal: true

# ユーザー関連のクラスを名前空間としてまとめたモジュール
module Users
  # RegistrationsControllerは、Devise gemを利用したユーザー登録に関するアクションを処理します。
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :ensure_normal_user

    # ユーザーの新規登録を処理するメソッド
    def create
      super do |resource|
        handle_resource_persistence(resource)
      end
    end

    # ゲストユーザーでないことを確認するメソッド
    def ensure_normal_user
      return unless guest_user?

      handle_guest_user_actions
    end

    protected

    # サインアップ時のパラメータを設定するメソッド
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    # サインアップ後のリダイレクト先を定義するメソッド
    def after_sign_up_path_for(_resource)
      account_path
    end

    private

    # ユーザーがゲストかどうかを確認するメソッド
    def guest_user?
      resource.email == 'guest_user@example.com'
    end

    # ゲストユーザーの操作に対する処理を行うメソッド
    def handle_guest_user_actions
      if user_action_present?
        add_guest_user_restriction_error
        redirect_to_edit_user_registration
      elsif withdrawal_action?
        redirect_to_root_with_alert
      end
    end

    # ユーザーアクションが存在するかどうかを確認するメソッド
    def user_action_present?
      params[:user][:name].present? || params[:user].present? || params[:user][:image].present?
    end

    # ユーザー登録の永続性を確認し、それに応じた処理を行うメソッド
    def handle_resource_persistence(resource)
      if resource.persisted?
        prepare_flash_message(resource)
      else
        prepare_resource_for_retry(resource)
      end
    end

    # ゲストユーザーに対する制限エラーを追加するメソッド
    def add_guest_user_restriction_error
      resource.errors.add(:base, I18n.t('errors.guest_user_restriction'))
    end

    # ユーザー登録の編集ページにリダイレクトするメソッド
    def redirect_to_edit_user_registration
      redirect_to edit_user_registration_path and return
    end

    # 退会アクションが存在するかどうかを確認するメソッド
    def withdrawal_action?
      params[:action] == 'withdrawal'
    end

    # ルートページにアラートメッセージ付きでリダイレクトするメソッド
    def redirect_to_root_with_alert
      redirect_to root_path, alert: I18n.t('errors.guest_user_withdrawal') and return
    end

    # リソースの状態に基づいて適切なフラッシュメッセージを設定するメソッド
    def prepare_flash_message(resource)
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      end
    end

    # 再試行のためのリソースの準備を行うメソッド
    def prepare_resource_for_retry(resource)
      clean_up_passwords resource
      set_minimum_password_length
      flash[:alert] = resource.errors.full_messages.join(', ')
      redirect_to new_user_registration_path and return
    end
  end
end
