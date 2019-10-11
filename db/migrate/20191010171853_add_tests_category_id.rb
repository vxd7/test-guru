class AddTestsCategoryId < ActiveRecord::Migration[6.0]
  def change
    add_column(:tests, :category_id, :integer)
  end
end
