require 'rails_helper'

RSpec.describe AnswersController, type: :request do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:valid_params) { { body: "New answer body" } }
  let(:invalid_params) { { body: "" } }

  describe "GET #index" do
    it "成功したレスポンスを返すこと" do
      sign_in user
      get question_answers_path(question) # /questions/:question_id/answersにGETリクエストを送る
      expect(response).to be_successful # レスポンスが成功していることを期待する
    end
  end

  describe "GET #show" do
    it "成功したレスポンスを返すこと" do
      sign_in user
      get answer_path(answer)
      expect(response).to be_successful # レスポンスが成功していることを期待する
    end
  end

  describe "GET #new" do
    it "成功したレスポンスを返すこと" do
      sign_in user
      get new_question_answer_path(question) # /questions/:question_id/answers/newにGETリクエストを送る
      expect(response).to be_successful # レスポンスが成功していることを期待する
    end
  end

  describe "POST #create" do
    context "有効なパラメータの場合" do
      it "新しい回答を作成する" do
        sign_in user
        expect {
          post question_answers_path(question), params: { answer: valid_params } # /questions/:question_id/answersにPOSTリクエストを送る
        }.to change(Answer, :count).by(1) # Answerの数が1増えることを期待する
      end
    end

    context "無効なパラメータの場合" do
      it "新しい回答を作成しない" do
        sign_in user
        expect {
          post question_answers_path(question), params: { answer: invalid_params } # /questions/:question_id/answersにPOSTリクエストを送る
        }.to change(Answer, :count).by(0) # Answerの数が変わらないことを期待する
      end
    end
  end

  describe "PUT #update" do
    context "有効なパラメータの場合" do
      it "要求された回答を更新する" do
        sign_in user
        put answer_path(answer), params: { answer: valid_params }
        answer.reload # データベースから最新の情報を読み込む
        expect(answer.body).to eq("New answer body") # answer.bodyが更新されていることを期待する
      end
    end

    context "無効なパラメータの場合" do
      it "回答を更新しない" do
        sign_in user
        put answer_path(answer), params: { answer: invalid_params }
        answer.reload # データベースから最新の情報を読み込む
        expect(answer.body).not_to eq("") # answer.bodyが空でないことを期待する
      end
    end
  end

  describe "DELETE #destroy" do
    it "要求された回答を削除する" do
      sign_in user
      answer # answerを作成
      expect {
        delete answer_path(answer)
      }.to change(Answer, :count).by(-1) # Answerの数が1減ることを期待する
    end
  end
end
