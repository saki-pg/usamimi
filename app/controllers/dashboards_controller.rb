# frozen_string_literal: true

class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def account
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(params.require(:user).permit(:name, :introduction, :image))
      flash[:notice] = 'ユーザープロフィールの情報を更新しました'
      redirect_to account_path
    else
      render 'account'
    end
  end

  # def update
  #   @user= current_user
  #   @dashboard = current_user.dashboard
  #   if @dashboard.update(dashboard_params)
  #     redirect_to account_dashboards_path, notice: 'アカウント情報を更新しました'
  #   else
  #     render :account
  #   end
  # end

  def unsubscribe
    @user = current_user
  end

  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = '退会処理を実行いたしました'
    redirect_to root_path
  end


  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
