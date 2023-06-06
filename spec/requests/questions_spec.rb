require 'rails_helper'

RSpec.describe "Questions", type: :request do
  # ユーザーを作成し、そのユーザーでサインイン
  let(:user) { create(:user) }
  before do
    sign_in user
  end

  # 質問の一覧ページに関するテスト
  describe "GET /index" do
    it "HTTPステータスが成功を返すこと" do
      get questions_path
      expect(response).to have_http_status(:success)
    end
  end

  # 質問の詳細ページに関するテスト
  describe "GET /show" do
    let(:question) { create(:question, user: user) }
    it "HTTPステータスが成功を返すこと" do
      get question_path(question)
      expect(response).to have_http_status(:success)
    end
  end

  # 質問の新規作成ページに関するテスト
  describe "GET /new" do
    it "HTTPステータスが成功を返すこと" do
      get new_question_path
      expect(response).to have_http_status(:success)
    end
  end

  # 質問の編集ページに関するテスト
  describe "GET /edit" do
    let(:question) { create(:question, user: user) }
    it "HTTPステータスが成功を返すこと" do
      get edit_question_path(question)
      expect(response).to have_http_status(:success)
    end
  end

  # 質問の作成に関するテスト
  describe "POST /create" do
    context "有効なパラメータの場合" do
      it "新しい質問が作成されること" do
        expect {
          post questions_path, params: { question: attributes_for(:question) }
        }.to change(Question, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "新しい質問が作成されないこと" do
        expect {
          post questions_path, params: { question: attributes_for(:question, title: nil) }
        }.not_to change(Question, :count)
      end
    end
  end

  # 質問の更新に関するテスト
  describe "PUT /update" do
    let(:question) { create(:question, user: user, title: 'Old title') }
    context "有効なパラメータの場合" do
      it "質問が更新されること" do
        put question_path(question), params: { question: { title: 'New title' } }
        question.reload
        expect(question.title).to eq 'New title'
      end
    end

    context "無効なパラメータの場合" do
      it "質問が更新されないこと" do
      put question_path(question), params: { question: { title: '' } }
      question.reload
      expect(question.title).to eq 'Old title'
      end
    end
  end

  # 質問の削除に関するテスト
  describe "DELETE /destroy" do
    # let!(:question) とすることで、テストが実行される直前に質問作成
    let!(:question) { create(:question, user: user) }
    it "質問が削除されること" do
      expect {
        delete question_path(question)
      }.to change(Question, :count).by(-1)
    end
  end
end
