class AddViewsCountToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :views_count, :integer, default: 0
  end
end
