class AddAnswersCorrectColumn < ActiveRecord::Migration[6.0]
  def change
    add_column(:answers, :correct, :boolean)
    change_column_null(:answers, :correct, false)
  end
end
