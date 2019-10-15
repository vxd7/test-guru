class User < ApplicationRecord
  # User can be an author of many tests
  has_many :tests, foreign_key: :author_id
  has_many :user_tests
  has_many :tests, through: :user_tests

  def user_tests_by_level(level)
    Test.joins('JOIN user_tests ON user_tests.test_id = tests.id')
        .where(user_tests: { user_id: id }, level: level)
  end
end
