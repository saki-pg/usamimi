require 'rails_helper'

RSpec.describe Question, type: :model do
  it "有効なファクトリを持つこと" do
    expect(build(:question)).to be_valid
  end

  describe '関連付け' do
    it { should belong_to(:user) } # ユーザーとの関連付けを確認
    it { should have_many(:answers).dependent(:destroy) } # 回答との関連付けを確認（依存関係：削除）
    it { should have_many(:question_tags).dependent(:destroy) } # 質問タグとの関連付けを確認（依存関係：削除）
    it { should have_many(:tags).through(:question_tags) } # タグとの関連付けを確認（質問タグを介して）
  end

  describe 'バリデーション' do
    it { should validate_presence_of(:title) } # タイトルの存在を確認
    it { should validate_presence_of(:body) } # 本文の存在を確認
  end
end
