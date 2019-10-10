class AddDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_defaults(:tests, :level, from: nil, to: 0)
    change_column_defaults(:answers, :correct, from: nil, to: false)
  end
end
