class Test < ApplicationRecord
  def self.tests_by_category(category)
    tests = Test.joins('JOIN categories ON tests.category_id = categories.id')
    tests.where('categories.name = :cat_name', cat_name: category).order('id DESC')
  end
end
