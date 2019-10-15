class Test < ApplicationRecord
  def self.tests_by_category(category)
    joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { name: category })
      .order('tests.id DESC')
      .pluck(:title)
  end

  # Test belongs to one author
  belongs_to :author, class_name: :User, foreign_key: :author_id

  has_many :user_tests
  has_many :users, through: :user_tests

  has_many :questions
end
