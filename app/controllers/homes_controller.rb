# frozen_string_literal: true

class HomesController < ApplicationController
  def top
    # @questions = Question.all
    @questions = Question.all.order(created_at: :desc)
  end

  # def top
  #   if params[:order] == 'answered'
  #     # ベストアンサーが設定されている質問を最初に表示
  #     @questions = Question.where.not(best_answer_id: nil).order(updated_at: :desc)
  #     # ベストアンサーが設定されていない質問を続けて表示
  #     @questions += Question.where(best_answer_id: nil).order(updated_at: :desc)
  #   else
  #     # 新着順に質問を表示
  #     @questions = Question.all.order(created_at: :desc)
  #   end
  # end

  # def top
  #   if params[:order] == 'answered'
  #     @questions = Question.answered
  #   else
  #     @questions = Question.recent
  #   end

  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end
end
