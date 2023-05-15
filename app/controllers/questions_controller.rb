# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[search]
  before_action :set_question, only: %i[show edit update destroy]
  before_action :set_best_answer, only: %i[update]

  # GET /questions or /questions.json
  def index
    @questions = current_user.questions.all
  end

  # GET /questions/1 or /questions/1.json
  def show; end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit; end

  # POST /questions or /questions.json
  def create
    @question = current_user.questions.build(question_params)
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: '質問を投稿しました。' }
        format.json { render :show, status: :created, location: @question }
      else
        flash[:error] = '質問を投稿できませんでした。入力内容を確認してください。'
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1 or /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to question_url(@question), notice: '質問を更新しました。' }
        format.json { render :show, status: :ok, location: @question }
      else
        flash[:error] = '質問を更新できませんでした。入力内容を確認してください。'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1 or /questions/1.json
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url, notice: '質問を削除しました。' }
      format.json { head :no_content }
    end
  end

  # def search
  #   if params[:keyword].present?
  #     @questions = Question.where("title LIKE ? OR body LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%")
  #   else
  #     @questions = Question.all
  #   end
  #   @cnt = @questions.count
  # end

  def search
    if params[:keyword].nil?
      @question = Question.all
      @cnt = Question.all.count
    elsif params[:keyword] == ''
      @question = Question.all
      @cnt = Question.all.count
    elsif  params[:keyword]
      @question = Question.where('title LIKE?',
                                 "%#{params[:keyword]}%").or(Question.where('body LIKE?',
                                                                            "%#{params[:keyword]}%"))
      @cnt = Question.where('title LIKE?',
                            "%#{params[:keyword]}%").or(Question.where('body LIKE?',
                                                                       "%#{params[:keyword]}%")).count
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:user_id, :title, :body, :best_answer_id)
  end

  def set_best_answer
    return if @question.best_answer_id.blank?

    redirect_to @question, alert: 'ベストアンサーが選択された後は編集できません。'
  end
end
