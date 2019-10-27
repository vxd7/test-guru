class User < ApplicationRecord
  # User can be an author of many tests
  has_many :authored_tests, class_name: :Test, foreign_key: :author_id,
                            dependent: :nullify
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  validates :email, presence: true

  def user_tests_by_level(level)
    # Test.joins('JOIN test_passages ON test_passages.test_id = tests.id')
    # Test.joins(:test_passages)
    Test.joins(:users)
        .where(test_passages: { user_id: id }, level: level)
  end
end
