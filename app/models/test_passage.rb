class TestPassage < ApplicationRecord
  SUCCESS_RATE = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: :Question, optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :set_next_question, on: :update

  def accept!(answer_ids)
    if correct_answer?(answer_ids)
      self.correct_questions += 1
    end

    # self.current_question = next_question
    save!
  end

  def completed?
    current_question.nil?
  end

  def success_rate
    (self.correct_questions.to_f / self.test.questions.count) * 100.0
  end

  def success?
    success_rate >= SUCCESS_RATE
  end

  def passage_current_question_index
    test.questions.order(:id).index(current_question) + 1
  end

  private

  def before_validation_set_first_question
    self.current_question = test.questions.first if test.present?
  end

  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count

    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
      correct_answers_count == answer_ids.count
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    test.questions.order(:id).where('id > ?', current_question.id).first
  end

  def set_next_question
    self.current_question = next_question
  end
end
