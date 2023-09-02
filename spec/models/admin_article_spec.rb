require 'rails_helper'

RSpec.describe AdminArticle, type: :model do
  it "有効なファクトリを持つこと" do
    expect(build(:admin_article)).to be_valid
  end

  describe 'バリデーション' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end
end
