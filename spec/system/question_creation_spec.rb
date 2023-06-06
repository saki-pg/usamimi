require 'rails_helper'

RSpec.describe 'Questions', type: :system do
  let(:user) { FactoryBot.create(:user) }
  let(:question) { FactoryBot.create(:question, user: user) }

  before do
    sign_in user
  end

  describe '新規質問投稿' do
    it '正常に投稿できる' do
      visit new_question_path
      fill_in 'タイトル', with: 'Question title', wait: 5
      fill_in '内容', with: 'Question body', wait: 5
      click_button '投稿'
      
      expect(page).to have_content '質問を投稿しました'
      expect(page).to have_content 'Question title'
      expect(page).to have_content 'Question body'
    end
  end

  describe '質問詳細表示' do
    it '質問とその詳細が表示される' do
      visit question_path(question)

      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
end
