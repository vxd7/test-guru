class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  # User can be an author of many tests
  has_many :authored_tests, class_name: :Test, foreign_key: :author_id,
                            dependent: :nullify
  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    uniqueness: true

  # has_secure_password

  def user_tests_by_level(level)
    # Test.joins('JOIN test_passages ON test_passages.test_id = tests.id')
    # Test.joins(:test_passages)
    Test.joins(:users)
        .where(test_passages: { user_id: id }, level: level)
  end

  def test_passage(test)
    test_passages.order(id: :desc).find_by(test_id: test.id)
  end
end
