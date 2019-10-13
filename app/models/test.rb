class Test < ApplicationRecord
  def self.tests_by_category(category)
    tests = joins('JOIN categories ON tests.category_id = categories.id')
    tests = tests.where('categories.name = :cat_name', cat_name: category).order('tests.id DESC').select(:title)

    res = []
    tests.each { |test| res << test.title }
    res
  end
end
