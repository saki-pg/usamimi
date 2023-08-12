# frozen_string_literal: true

class User < ApplicationRecord
  # ユーザーの認証情報管理と、ユーザーが関連付ける質問、ダッシュボード、画像などを管理
  def self.guest
    find_or_create_by!(email: 'guest_user@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
    end
  end

  def active_for_authentication?
    super && !is_deleted
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_one_attached :image

  has_one :dashboard, dependent: :destroy
  accepts_nested_attributes_for :dashboard

  validates :name, presence: true
  validates :email, presence: true
end
