# frozen_string_literal: true

# ユーザーの返信を処理するクラス
class ReactionsController < ApplicationController
  before_action :set_reaction, only: %i[show edit update destroy]
  before_action :find_answer, only: %i[new create]
  before_action :ensure_correct_user, only: %i[edit update destroy]

  # 全てのリアクションを表示する
  def index
    @reactions = Reaction.all
  end

  # 特定のリアクションを表示する
  def show; end

  # 新しいリアクションを作成するための画面
  def new
    @reaction = @answer.reactions.build(user_id: current_user.id)
  end

  # リアクションを編集するための画面
  def edit; end

  # 新しいリアクションを作成する
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

  # リアクションを更新する
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

  # リアクションを削除する
  def destroy
    @reaction.destroy

    respond_to do |format|
      format.html { redirect_to @reaction.answer.question, notice: t('reaction.delete.success') }
      format.json { head :no_content }
    end
  end

  private

  # 共通のセットアップまたは制約を共有する
  def set_reaction
    @reaction = Reaction.find(params[:id])
  end

  # 回答を見つける
  def find_answer
    @answer = Answer.find(params[:answer_id])
  end

  # 信頼できるパラメータのリストのみを通す
  def reaction_params
    params.require(:reaction).permit(:answer_id, :body)
  end

  # 正しいユーザーか確認する
  def ensure_correct_user
    redirect_to(root_path) unless @reaction.user_id == current_user.id
  end
end
