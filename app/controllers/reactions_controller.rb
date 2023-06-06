# frozen_string_literal: true

# ユーザーの返信を処理するクラス
class ReactionsController < ApplicationController
  before_action :set_reaction, only: %i[show edit update destroy]
  before_action :find_answer, only: %i[new create]

  # GET /reactions or /reactions.json
  def index
    @reactions = Reaction.all
  end

  # GET /reactions/1 or /reactions/1.json
  def show; end

  # GET /reactions/new
  def new
    @reaction = @answer.reactions.build(user_id: current_user.id)
  end

  # GET /reactions/1/edit
  def edit; end

  # POST /reactions or /reactions.json
  def create
    @reaction = @answer.reactions.build(reaction_params.merge(user_id: current_user.id))

    respond_to do |format|
      if @reaction.save
        format.html { redirect_to @answer.question, notice: t('reaction.create.success') }
        format.json { render :show, status: :created, location: @reaction }
      else
        flash[:error] = t('reaction.create.fail')
        format.html { render :new }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reactions/1 or /reactions/1.json
  def update
    respond_to do |format|
      if @reaction.update(reaction_params)
        format.html { redirect_to reaction_url(@reaction), notice: t('reaction.update.success') }
        format.json { render :show, status: :ok, location: @reaction }
      else
        flash[:error] = t('reaction.update.fail')
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reactions/1 or /reactions/1.json
  def destroy
    @reaction.destroy

    respond_to do |format|
      format.html { redirect_to reactions_url, notice: t('reaction.delete.success') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  def find_answer
    @answer = Answer.find(params[:answer_id])
  end

  # Only allow a list of trusted parameters through.
  def reaction_params
    params.require(:reaction).permit(:answer_id, :body)
  end
end
