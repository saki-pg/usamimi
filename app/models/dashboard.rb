# frozen_string_literal: true

# ダッシュボードはユーザーに関連づけられる
class Dashboard < ApplicationRecord
  belongs_to :user
end
