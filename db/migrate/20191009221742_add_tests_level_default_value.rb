class AddTestsLevelDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:tests, :level, from: -1, to: 0)
  end
end
