# frozen_string_literal: true

class ReactionsController < ApplicationController
  before_action :set_reaction, only: %i[show edit update destroy]

  # GET /reactions or /reactions.json
  def index
    @reactions = Reaction.all
  end

  # GET /reactions/1 or /reactions/1.json
  def show; end

  # GET /reactions/new
  def new
    @answer = Answer.find(params[:answer_id])
    @reaction = @answer.reactions.build(user_id: current_user.id)
  end

  # GET /reactions/1/edit
  def edit; end

  # POST /reactions or /reactions.json
  def create
    @answer = Answer.find(params[:answer_id])
    @reaction = @answer.reactions.build(reaction_params)

    respond_to do |format|
      if @reaction.save
        format.html { redirect_to @answer.question, notice: '返信を投稿しました。' }
        format.json { render :show, status: :created, location: @reaction }
      else
        flash[:error] = '返信を投稿できませんでした。入力内容を確認してください。'
        format.html { render :new }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reactions/1 or /reactions/1.json
  def update
    respond_to do |format|
      if @reaction.update(reaction_params)
        format.html { redirect_to reaction_url(@reaction), notice: '返信を更新しました。' }
        format.json { render :show, status: :ok, location: @reaction }
      else
        flash[:error] = '返信を更新できませんでした。入力内容を確認してください。'
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reactions/1 or /reactions/1.json
  def destroy
    @reaction.destroy

    respond_to do |format|
      format.html { redirect_to reactions_url, notice: '返信を削除しました。' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reaction_params
    params.require(:reaction).permit(:user_id, :answer_id, :body)
  end
end
