# frozen_string_literal: true

# 質問の作成、読み取り、更新、削除、検索
class QuestionsController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_best_answer, only: %i[update]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  # 質問一覧表示
  def index
    @tags = Tag.all
    if params[:tag]
      @tag = Tag.find_by(name: params[:tag])
      @questions = @tag ? @tag.questions : Question.none
    else
      @questions = current_user.questions.all
    end
  end

  # 質問詳細表示
  def show; end

  # 新規質問作成
  def new
    @question = Question.new
    @tags = Tag.all
  end

  # 質問編集
  def edit
    @tags = Tag.all
  end

  # 質問投稿
  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: t('.success') }
        format.json { render :show, status: :created, location: @question }
      else
        flash[:error] = t('.error')
        @tags = Tag.all
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: t('.success') }
        format.json { render :show, status: :ok, location: @question }
      else
        # flash[:error] = t('.error')
        flash[:error] = @question.errors.full_messages.join(', ')
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

  private

  # 共通の設定や制約を共有するためのコールバック
  def set_question
    @question = Question.find(params[:id])
    @tags = Tag.all
  end

  # 信頼できるパラメータのみ許可する
  def question_params
    params.require(:question).permit(:title, :body, :image, :best_answer_id, { tag_ids: [] })
  end

  # ベストアンサーのセット
  def set_best_answer
    return if @question.best_answer_id.blank?

    redirect_to @question, alert: t('questions.update.best_answer_chosen')
  end

  # 正しいユーザーか確認する
  def ensure_correct_user
    redirect_to(questions_path) unless @question.user_id == current_user.id
  end
end
