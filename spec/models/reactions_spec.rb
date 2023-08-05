require 'rails_helper'

RSpec.describe Reaction, type: :model do
  it "有効なファクトリを持つこと" do
    expect(build(:reaction)).to be_valid
  end

  describe '関連付け' do
    it { should belong_to(:user) } # ユーザーとの関連付けを確認
    it { should belong_to(:answer) } # 回答との関連付けを確認
  end

  describe 'バリデーション' do
    it { should validate_presence_of(:body) } # 反応内容の存在を確認
  end
end
