# frozen_string_literal: true

# 質問に対する回答を管理するコントローラ
class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[show edit update destroy]

  # GET /answers or /answers.json
  def index
    @order = params[:order]
    @questions = load_questions(@order)
  end

  # GET /answers/1 or /answers/1.json
  def show; end

  # GET /answers/new
  def new
    load_question
    @answer = Answer.new(user_id: current_user.id, question_id: @question.id)
  end

  # GET /answers/1/edit
  def edit; end

  # POST /answers or /answers.json
  def create
    load_question
    @answer = @question.answers.build(answer_params.merge(user_id: current_user.id))
    save_or_render_answer(:new, t('answer.create.success'), t('answer.create.fail'))
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    update_or_render_answer(t('answer.update.success'), t('answer.update.fail'))
  end

  # DELETE /answers/1 or /answers/1.json
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

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_questions(order)
    case order
    when 'recent'
      Question.order(created_at: :desc)
    when 'resolved'
      Question.where.not(best_answer_id: nil).order(updated_at: :desc)
    else
      Question.all
    end
  end

  def save_or_render_answer(fail_action, success_msg, fail_msg)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: success_msg }
        format.json { render :show, status: :created, location: @answer }
      else
        flash[:error] = fail_msg
        format.html { render fail_action }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

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
end
