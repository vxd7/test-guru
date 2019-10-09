class AddAnswersNullConstraints < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:answers, :question_id, false)
    change_column_null(:answers, :user_id, false)
  end
end
