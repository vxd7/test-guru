class TestPassage < ApplicationRecord
  SUCCESS_RATE = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: :Question, optional: true

  before_validation :set_current_question
  # before_validation :before_validation_set_first_question, on: :create
  # before_validation :set_next_question, on: :update

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    self.success = success?

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
    test.questions.where('id < ?', current_question.id).count + 1
    # test.questions.order(:id).index(current_question) + 1
  end

  def timed?
    !test.timelimit.nil?
  end

  def timed_out?
    time_left.negative? || time_left.zero?
  end

  def time_left
    time_after_start = (Time.now - created_at.to_time) / 1.minute
    (test.timelimit.to_i.minutes - time_after_start) / 1.minute
  end

  private

  def set_current_question
    self.current_question = next_question
  end

  def next_question
    if current_question.nil?
      test.questions.first
    else
      test.questions.order(:id).where('id > ?', current_question.id).first
    end
  end

  def correct_answer?(answer_ids)
    correct_answers_count = correct_answers.count

    (correct_answers_count == correct_answers.where(id: answer_ids).count) &&
      correct_answers_count == answer_ids.count
  end

  def correct_answers
    current_question.answers.correct
  end
end
