# frozen_string_literal: true

# ホームページに関連するアクションを処理するクラス
class HomesController < ApplicationController
  # すべての質問を新しい順に取得し、ビューに渡すメソッド
  def top
    @tags = Tag.all
    @questions = Question.all.order(created_at: :desc).limit(12)
    @admin_articles = AdminArticle.order(created_at: :desc).limit(6)
  end

  # タグに関連する質問を取得し、ビューに渡すメソッド
  def tagged_questions
    @tag = Tag.find_by(name: params[:tag_name])
    @questions = @tag ? @tag.questions : Question.none
  end
end
