class AddQuestionsTestReference < ActiveRecord::Migration[6.0]
  def change
    add_reference(:questions, :test, foreign_key: {to_table: :tests})
    change_column_null(:questions, :test_id, false)
  end
end
