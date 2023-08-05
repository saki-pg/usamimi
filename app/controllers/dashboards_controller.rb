# frozen_string_literal: true

# ダッシュボード関連のアクション
# アカウント情報の表示、更新、退会処理等
class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[account update unsubscribe withdrawal]

  def account; end

  def update
    if @user.update(user_params)
      flash[:notice] = t('dashboard.update.success')
      redirect_to account_path
    else
      render 'account'
    end
  end

  def unsubscribe; end

  def withdrawal
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = t('dashboard.withdrawal.success')
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :image)
  end

  def set_user
    @user = current_user
  end
end
