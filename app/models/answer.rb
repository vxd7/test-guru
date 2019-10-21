class Answer < ApplicationRecord
  MAX_ANSWERS = 4
  MIN_ANSWERS = 1
  belongs_to :question

  validates :content, presence: true
  validate :validate_overall_answers_number

  scope :correct, -> { where(correct: true) }

  private

  def validate_overall_answers_number
    # Minus one here because our new answer should be MAX_ANSWERS'th answer
    return if question.answers.count.between?(MIN_ANSWERS, MAX_ANSWERS - 1)

    errors.add(:answer_count, "can be max #{MAX_ANSWERS} and min #{MIN_ANSWERS} for a given question")
  end
end
