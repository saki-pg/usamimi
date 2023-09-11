# frozen_string_literal: true

class User < ApplicationRecord
  # Deviseの設定
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  # ゲストユーザーの取得または作成
  def self.guest
    find_or_create_by!(email: 'guest_user@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
    end
  end

  # ユーザーが認証のために活動できるかどうかを確認
  def active_for_authentication?
    super && !is_deleted
  end

  # 関連付け
  has_many :questions, dependent: :destroy
  has_one_attached :image
  has_one :dashboard, dependent: :destroy

  # 受け入れる属性
  accepts_nested_attributes_for :dashboard

  # バリデーション
  validates :name, presence: true
  validates :email, presence: true
end
