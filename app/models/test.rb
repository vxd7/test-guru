class Test < ApplicationRecord
  def self.tests_by_category(category)
    joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { name: category })
      .order('tests.id DESC')
      .pluck(:title)
  end
end
