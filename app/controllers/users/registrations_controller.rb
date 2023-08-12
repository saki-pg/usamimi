# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :ensure_normal_user, only: [:create, :edit, :update, :destroy]

    # ユーザーの新規登録を行う
    def create
      build_resource(sign_up_params)
      yield resource if block_given?

      if resource.save
        handle_successful_resource_creation(resource)
      else
        handle_resource_error(resource)
      end
    end

    protected

    # 新規登録の際のパラメータの設定
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    # 新規登録後のリダイレクト先を設定
    def after_sign_up_path_for(_resource)
      account_path
    end

    private

    # ユーザーがゲストユーザーかを確認
    def guest_user?
      resource&.email == 'guest_user@example.com'
    end

    # 通常のユーザーであることを確認。ゲストユーザーの場合は処理を行う。
    def ensure_normal_user
      handle_guest_user_actions if guest_user?
    end

    # ゲストユーザーのアクションを処理
    def handle_guest_user_actions
      if user_action_present?
        add_guest_user_restriction_error
        redirect_to_edit_user_registration
      elsif withdrawal_action?
        redirect_to_root_with_alert
      end
    end

    # ユーザーアクションが存在するかを確認
    def user_action_present?
      params[:user][:name].present? || params[:user].present? || params[:user][:image].present?
    end

    # リソースが正常に作成された場合の処理
    def handle_successful_resource_creation(resource)
      set_flash_for(resource)
      
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    end

    # リソース作成エラー時の処理
    def handle_resource_error(resource)
      clean_up_passwords resource
      set_minimum_password_length
      flash[:alert] = resource.errors.full_messages.join(', ')
      redirect_to new_user_registration_path
    end

    # ゲストユーザーにエラーメッセージを追加
    def add_guest_user_restriction_error
      resource.errors.add(:base, I18n.t('errors.guest_user_restriction'))
    end

    # ユーザー登録編集ページへのリダイレクト
    def redirect_to_edit_user_registration
      redirect_to edit_user_registration_path
    end

    # 退会アクションの存在を確認
    def withdrawal_action?
      params[:action] == 'withdrawal'
    end

    # アラートを表示してルートページへリダイレクト
    def redirect_to_root_with_alert
      redirect_to root_path, alert: I18n.t('errors.guest_user_withdrawal')
    end

    # ユーザー登録成功時のフラッシュメッセージを設定
    def set_flash_for(resource)
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
      end
    end
  end
end
