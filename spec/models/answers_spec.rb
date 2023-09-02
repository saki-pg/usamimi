require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe '関連付け' do
    it { should belong_to(:user) } # ユーザーとの関連付け
    it { should belong_to(:question) } # 質問との関連付け
    it { should have_many(:reactions).dependent(:destroy) } # リアクションとの関連付け（依存関係：削除）
  end

  describe 'バリデーション' do
    it { should validate_presence_of(:body) } # 本文の存在確認
  end

  describe '依存関係' do
    let(:question) { create(:question) }
    let(:user) { create(:user) }
    let!(:answer) { create(:answer, question: question, user: user) }

    it '回答が削除された際、関連するリアクションも削除される' do
      create_list(:reaction, 3, answer: answer)
      expect { answer.destroy }.to change { Reaction.count }.by(-3)
    end

    it '回答が削除されても、関連するユーザーは削除されない' do
      expect { answer.destroy }.not_to change { User.count }
    end

    it '回答が削除されても、関連する質問は削除されない' do
      expect { answer.destroy }.not_to change { Question.count }
    end
  end
end
