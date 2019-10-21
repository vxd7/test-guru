class Answer < ApplicationRecord
  MAX_ANSWERS = 4
  belongs_to :question

  validates :content, presence: true
  validate :validate_overall_answers_number

  scope :correct, -> { where(correct: true) }

  private

  def validate_overall_answers_number
    return unless question.answers.count >= MAX_ANSWERS

    errors.add(:answer_count, "can be max #{MAX_ANSWERS} for a given question")
  end
end
