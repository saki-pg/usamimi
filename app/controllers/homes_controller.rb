# frozen_string_literal: true

# ホームページに関連するアクションを処理するクラス
class HomesController < ApplicationController
  # すべての質問を新しい順に取得し、ビューに渡すメソッド
  def top
    @questions = Question.all.order(created_at: :desc)
  end
end
