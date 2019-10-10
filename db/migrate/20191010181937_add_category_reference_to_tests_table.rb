class AddCategoryReferenceToTestsTable < ActiveRecord::Migration[6.0]
  def change
    add_reference(:tests, :category, foreign_key: {to_table: :categories})
    change_column_null(:tests, :category_id, false)
  end
end
