class AddDescriptionToBadges < ActiveRecord::Migration[6.0]
  def change
    add_column :badges, :description, :string
  end
end
