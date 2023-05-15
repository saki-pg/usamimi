# frozen_string_literal: true

module Dashboards
  class UsersController < ApplicationController
    def withdrawal
      @user = User.find(params[:id])
      @user.update(is_deleted: true)
      reset_session
      flash[:notice] = '退会処理を実行いたしました'
      redirect_to root_path
    end
  end
end
