class AddAnswersQuestionReference < ActiveRecord::Migration[6.0]
  def change
    # add_reference(:answers, :question, foreign_key: {to_table: :questions})
    add_reference(:answers, :question, foreign_key: true)
    change_column_null(:answers, :question_id, false)
  end
end
