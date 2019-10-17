class User < ApplicationRecord
  # User can be an author of many tests
  has_many :authored_tests, class_name: :Test, foreign_key: :author_id,
                            dependent: :nullify
  has_many :user_tests, dependent: :destroy
  has_many :tests, through: :user_tests

  def user_tests_by_level(level)
    # Test.joins('JOIN user_tests ON user_tests.test_id = tests.id')
    # Test.joins(:user_tests)
    Test.joins(:users)
        .where(user_tests: { user_id: id }, level: level)
  end
end
