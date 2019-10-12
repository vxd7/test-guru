class AddQuestionsTestReference < ActiveRecord::Migration[6.0]
  def change
    # add_reference(:questions, :test, foreign_key: {to_table: :tests})
    add_reference(:questions, :test, foreign_key: true)
    change_column_null(:questions, :test_id, false)
  end
end
