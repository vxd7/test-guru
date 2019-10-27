class Test < ApplicationRecord
  # define difficulty levels
  EZ_DIFFICULTY = (0..1).freeze
  NORM_DIFFICULTY = (2..4).freeze
  HARD_DIFFICULTY = (5..Float::INFINITY).freeze

  # Test belongs to one author
  belongs_to :author, class_name: :User, foreign_key: :author_id, optional: true
  belongs_to :category, optional: true

  has_many :test_passages, dependent: :destroy
  has_many :users, through: :test_passages
  has_many :questions, dependent: :destroy

  validates :title, presence: true, uniqueness: { scope: :level, message: 'can be only one test with given title and level' }
  validates :level, numericality: { only_integer: true, greater_then_or_equal_to: 0 }

  scope :easy, -> { where(level: EZ_DIFFICULTY) }
  scope :normal, -> { where(level: NORM_DIFFICULTY) }
  scope :hard, -> { where(level: HARD_DIFFICULTY) }

  scope :tests_by_category, ->(category) { joins(:category).where(categories: { name: category }).order(id: :desc) }

  def self.tests_by_category_array(category)
    # joins('JOIN categories ON tests.category_id = categories.id')
    tests_by_category(category).pluck(:title)
  end
end
