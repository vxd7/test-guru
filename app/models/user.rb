class User < ApplicationRecord
  def user_tests_by_level(level)
    Test.joins('JOIN user_tests ON user_tests.test_id = tests.id')
        .where(user_tests: { user_id: id }, level: level)
  end

  # User can be an author of many tests
  has_many :tests, foreign_key: :author_id
end
