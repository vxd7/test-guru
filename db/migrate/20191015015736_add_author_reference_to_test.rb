class AddAuthorReferenceToTest < ActiveRecord::Migration[6.0]
  def change
    add_reference :tests, :author, foreign_key: {to_table: :users}
    change_column_null(:tests, :author_id, true)
  end
end
