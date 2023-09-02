# frozen_string_literal: true

# 質問に対する回答を管理するコントローラ
class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[show edit update destroy]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  # 回答一覧を表示する
  def index
    @order = params[:order]
    @questions = load_questions(@order)
  end

  # 回答詳細を表示する
  def show; end

  # 新しい回答を作成するフォームを表示する
  def new
    load_question
    @answer = Answer.new(user_id: current_user.id, question_id: @question.id)
  end

  # 回答の編集フォームを表示する
  def edit; end

  # 回答を作成する
  def create
    load_question
    @answer = @question.answers.build(answer_params.merge(user_id: current_user.id))
    save_or_render_answer(:new, t('answer.create.success'), t('answer.create.fail'))
  end

  # 回答を更新する
  def update
    if @answer.update(answer_params)
      redirect_to @answer, notice: t('answer.update.success')
    else
      flash[:error] = t('answer.update.fail')
      render :edit, status: :unprocessable_entity
    end
  end

  # 回答を削除する
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: t('answer.delete.success') }
      format.json { head :no_content }
    end
  end

  private

  # アクション間で共通のセットアップまたは制約を共有するためのコールバックを使用する
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # 信頼できるパラメータのリストのみを通す
  def answer_params
    params.require(:answer).permit(:question_id, :body)
  end

  # 質問を読み込む
  def load_question
    @question = Question.find(params[:question_id])
  end

  # 質問を順序付けて読み込む
  def load_questions(order)
    case order
    when 'recent'
      Question.order(created_at: :desc)
    when 'resolved'
      Question.where.not(best_answer_id: nil).order(updated_at: :desc)
    when 'popular'
      Question.order(views_count: :desc)
    else
      Question.all
    end
  end

  # 回答を保存またはレンダリングする
  def save_or_render_answer(fail_action, success_msg, fail_msg)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: success_msg }
        format.json { render :show, status: :created, location: @answer }
      else
        flash[:error] = fail_msg
        format.html { render fail_action, locals: { answer: @answer } }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # 回答を更新またはレンダリングする
  def update_or_render_answer(success_msg, fail_msg)
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to answer_url(@answer.question), notice: success_msg }
        format.json { render :show, status: :ok, location: @answer }
      else
        flash[:error] = fail_msg
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # 正しいユーザーか確認する
  def ensure_correct_user
    redirect_to(root_path) unless @answer.user_id == current_user.id
  end
end
