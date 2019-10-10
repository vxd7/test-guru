class AddUsersTestsQuestionsCategoriesAnswersNullConstraints < ActiveRecord::Migration[6.0]
  def change
    change_column_null(:answers, :question_id, false)
    change_column_null(:categories, :name, false)
    change_column_null(:questions, :content, false)
    change_column_null(:questions, :test_id, false)
    change_column_null(:tests, :title, false)
    change_column_null(:tests, :level, false)
    change_column_null(:users, :name, false)
  end
end
