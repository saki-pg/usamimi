# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: %i[show edit update destroy]

  # GET /answers or /answers.json
  # def index
  #   @questions = Question.all
  # end

  def index
    @order = params[:order]
    @questions = case @order
                 when 'recent'
                   Question.order(created_at: :desc)
                 when 'answered'
                   Question.includes(:answers).where.not(answers: { id: nil }).order('answers.created_at DESC')
                 else
                   Question.all
                 end
  end

  # # GET /answers/1 or /answers/1.json
  def show; end

  # # GET /answers/new
  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(user_id: current_user.id)
  end

  # GET /answers/1/edit
  def edit; end

  # POST /answers
  # POST /answers.json
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    respond_to do |format|
      if @answer.save
        format.html { redirect_to @answer, notice: '回答を投稿しました。' }
        format.json { render :show, status: :created, location: @answer }
      else
        flash[:error] = '回答を投稿できませんでした。入力内容を確認してください。'
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answers/1 or /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to answer_url(@answer.question), notice: '回答を更新しました。' }
        format.json { render :show, status: :ok, location: @answer }
      else
        flash[:error] = '回答を更新できませんでした。入力内容を確認してください。'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1 or /answers/1.json
  def destroy
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to answers_url, notice: '回答を削除しました。' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_answer
    @answer = Answer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def answer_params
    params.require(:answer).permit(:user_id, :question_id, :body)
  end
end
