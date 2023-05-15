class CreateReactions < ActiveRecord::Migration[6.1]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :answer, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
