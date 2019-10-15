class User < ApplicationRecord
  # User can be an author of many tests
  has_many :authored_tests, class_name: :Test, foreign_key: :author_id,
                            dependent: :restrict_with_exception
  has_many :user_tests, dependent: :restrict_with_exception
  has_many :tests, through: :user_tests, dependent: :restrict_with_exception

  def user_tests_by_level(level)
    Test.joins('JOIN user_tests ON user_tests.test_id = tests.id')
        .where(user_tests: { user_id: id }, level: level)
  end
end
