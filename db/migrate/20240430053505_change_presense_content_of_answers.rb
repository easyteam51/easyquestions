class ChangePresenseContentOfAnswers < ActiveRecord::Migration[7.1]
  def change
    change_column :answers, :content, :text, null: false
  end
end
