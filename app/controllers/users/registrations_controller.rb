# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_sign_up_params, only: [:create]
    before_action :ensure_normal_user, only: %i[update destroy]

    # before_action :configure_account_update_params, only: [:update]

    # GET /resource/sign_up
    # def new
    #   super
    # end

    # POST /resource
    def create
      super do |resource|
        if resource.persisted?
          if resource.active_for_authentication?
            set_flash_message! :notice, :signed_up
          else
            set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          end
        else
          clean_up_passwords resource
          set_minimum_password_length
          flash[:alert] = resource.errors.full_messages.join(', ')
          redirect_to new_user_registration_path and return
        end
      end
    end

    # POST /resource
    # def create
    #   build_resource(sign_up_params)

    #   if resource.save
    #     yield resource if block_given?
    #     if resource.active_for_authentication?
    #       set_flash_message! :notice, :signed_up
    #       sign_up(resource_name, resource)
    #       respond_with resource, location: after_sign_up_path_for(resource)
    #     else
    #       set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
    #       expire_data_after_sign_in!
    #       respond_with resource, location: after_inactive_sign_up_path_for(resource)
    #     end
    #   else
    #     clean_up_passwords resource
    #     set_minimum_password_length
    #     redirect_to new_user_registration_path, flash: {alert: resource.errors.full_messages.join(', ')}
    #   end
    # end

    # GET /resource/edit
    # def edit
    #   super
    # end

    # PUT /resource
    # def update
    #   super
    # end

    # DELETE /resource
    # def destroy
    #   super
    # end

    # GET /resource/cancel
    # Forces the session data which is usually expired after sign
    # in to be expired now. This is useful if the user wants to
    # cancel oauth signing in/up in the middle of the process,
    # removing all OAuth session data.
    # def cancel
    #   super
    # end

    def ensure_normal_user
      return unless resource.email == 'guest_user@example.com'

      if params[:user][:name].present? || params[:user][:introduction].present? || params[:user][:image].present?
        resource.errors.add(:base, 'ゲストユーザーの更新・削除・プロフィール画像・自己紹介の変更はできません。')
        redirect_to edit_user_registration_path and return
      elsif params[:action] == 'withdrawal'
        redirect_to root_path, alert: 'ゲストユーザーは退会できません。' and return
      end
    end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_up_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_account_update_params
    #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
    # end

    # The path used after sign up.
    # def after_sign_up_path_for(resource)
    #   super(resource)
    # end

    # The path used after sign up.
    def after_sign_up_path_for(_resource)
      account_path
    end

    # The path used after sign up for inactive accounts.
    # def after_inactive_sign_up_path_for(resource)
    #   super(resource)
    # end
  end
end
