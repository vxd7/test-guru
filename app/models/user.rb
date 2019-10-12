class User < ApplicationRecord
  def user_tests_by_level(level)
    tests = Test.joins('JOIN user_tests ON user_tests.test_id = tests.id')
    tests.where('user_tests.user_id = :user_id AND tests.level = :test_level',
                user_id: id, test_level: level)
  end
end
