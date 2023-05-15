class AddBestAnswerIdToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :best_answer_id, :integer, default: nil
  end
end
