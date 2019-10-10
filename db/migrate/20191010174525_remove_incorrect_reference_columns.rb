class RemoveIncorrectReferenceColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column(:answers, :question_id, :integer)
    remove_column(:questinos, :test_id, :integer)
  end
end
