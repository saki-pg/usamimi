require 'rails_helper'

RSpec.describe AnswersController, type: :request do
  describe 'POST /questions/:question_id/answers' do
    let(:question) { FactoryBot.create(:question) }
    let(:user) { FactoryBot.create(:user) }
    let(:valid_params) do
      { answer: { body: 'Answer body' } }
    end
    let(:invalid_params) do
      { answer: { body: '' } }
    end

    context 'ユーザーが認証されている場合' do
      before do
        sign_in user
      end

      context '有効なパラメータである場合' do
        it '新しい回答を作成する' do
          expect {
            post "/questions/#{question.id}/answers", params: valid_params
          }.to change(Answer, :count).by(1)

          expect(response).to redirect_to(assigns(:answer))
          follow_redirect!

          expect(response.body).to include('回答を投稿しました')
          expect(response.body).to include('Answer body')
        end
      end

      context '無効なパラメータである場合' do
        it '新しい回答を作成しない' do
          expect {
            post "/questions/#{question.id}/answers", params: invalid_params
          }.not_to change(Answer, :count)

          expect(response.body).to include('1 error prohibited this answer from being saved:')
          expect(response.body).to include('内容 を入力してください')
        end
      end
    end

    context 'ユーザーが認証されていない場合' do
      it 'サインインページにリダイレクトする' do
        post "/questions/#{question.id}/answers", params: valid_params

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
