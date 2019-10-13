class Test < ApplicationRecord
  def self.tests_by_category(category)
    joins('JOIN categories ON tests.category_id = categories.id')
      .where('categories.name = :cat_name', cat_name: category)
      .order('tests.id DESC')
      .pluck(:title)
  end
end
