# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  def self.guest
    find_or_create_by!(email: 'guest_user@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
    end
  end

  def active_for_authentication?
    super && !is_deleted
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :questions, dependent: :destroy
  has_one_attached :image

  has_one :dashboard
  accepts_nested_attributes_for :dashboard

  validates :name, presence: true
  validates :introduction, length: { maximum: 200 }, on: :update
end
