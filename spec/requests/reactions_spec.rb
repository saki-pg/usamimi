require 'rails_helper'

RSpec.describe ReactionsController, type: :request do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, user: user, question: question) }
  let(:reaction) { create(:reaction, user: user, answer: answer) }

  describe "POST /create" do
    context "有効なパラメータの場合" do
      it "新しいリアクションを作成する" do
        sign_in user
        expect {
          post answer_reactions_path(answer_id: answer.id), params: { reaction: { body: 'これはリアクションです.' } }
        }.to change(Reaction, :count).by(1)
      end
    end

    context "無効なパラメータの場合" do
      it "新しいリアクションは作成されない" do
        sign_in user
        expect {
          post answer_reactions_path(answer_id: answer.id), params: { reaction: { body: '' } }
        }.to_not change(Reaction, :count)
      end
    end
  end

  describe "PUT /update" do
    context "有効なパラメータの場合" do
      let(:new_body) { 'これは更新されたリアクションです.' }

      it "リクエストされたリアクションを更新する" do
        sign_in user
        put reaction_path(reaction), params: { reaction: { body: new_body } }
        reaction.reload
        expect(reaction.body).to eq(new_body)
      end
    end

    context "無効なパラメータの場合" do
      it "リアクションは更新されない" do
        sign_in user
        old_body = reaction.body
        put reaction_path(reaction), params: { reaction: { body: '' } }
        reaction.reload
        expect(reaction.body).to eq(old_body)
      end
    end
  end
end
