class AddTimelimitToTests < ActiveRecord::Migration[6.0]
  def change
    add_column :tests, :timelimit, :int
  end
end
