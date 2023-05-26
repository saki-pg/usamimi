# frozen_string_literal: true

# 質問の作成、読み取り、更新、削除、検索
class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[search]
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_best_answer, only: %i[update]

  # 質問一覧表示
  def index
    @questions = current_user.questions.all
  end

  # 質問詳細表示
  def show; end

  # 新規質問作成
  def new
    @question = Question.new
  end

  # 質問編集
  def edit; end

  # 質問投稿
  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: t('.success') }
        format.json { render :show, status: :created, location: @question }
      else
        flash[:error] = t('.error')
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # 質問更新
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: t('.success') }
        format.json { render :show, status: :ok, location: @question }
      else
        flash[:error] = t('.error')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # 質問削除
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url, notice: t('questions.delete.success') }
      format.json { head :no_content }
    end
  end

  # 検索機能
  def search
    if params[:keyword].blank?
      @question = Question.all
      @cnt = Question.all.count
    else
      @question = Question.where('title LIKE?',
                                 "%#{params[:keyword]}%").or(Question.where('body LIKE?', "%#{params[:keyword]}%"))
      @cnt = @question.count
    end
  end

  private

  # 共通の設定や制約を共有するためのコールバック
  def set_question
    @question = Question.find(params[:id])
  end

  # 信頼できるパラメータのみ許可する
  def question_params
    params.require(:question).permit(:user_id, :title, :body, :best_answer_id)
  end

  # ベストアンサーのセット
  def set_best_answer
    return if @question.best_answer_id.blank?

    redirect_to @question, alert: t('questions.update.best_answer_chosen')
  end
end
