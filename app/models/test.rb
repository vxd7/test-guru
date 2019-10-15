class Test < ApplicationRecord
  # Test belongs to one author
  belongs_to :author, class_name: :User, foreign_key: :author_id
  belongs_to :category

  has_many :user_tests, dependent: :destroy
  has_many :users, through: :user_tests, dependent: :destroy
  has_many :questions, dependent: :destroy

  def self.tests_by_category(category)
    # joins('JOIN categories ON tests.category_id = categories.id')
    joins(:category)
      .where(categories: { name: category })
      .order('tests.id DESC')
      .pluck(:title)
  end
end
