class TestPassage < ApplicationRecord
  SUCCESS_RATE = 85

  belongs_to :user
  belongs_to :test
  belongs_to :current_question, class_name: :Question, optional: true

  before_validation :set_current_question

  def accept!(answer_ids)
    if timed_out?
      self.success = false
      self.current_question = nil
    else
      self.correct_questions += 1 if correct_answer?(answer_ids)
      self.success = success?
    end

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
    timed? && time_left <= 0
  end

  def time_left
    time_after_start = (Time.now - created_at.to_time)
    test.timelimit.minutes.seconds - time_after_start
  end

  private

  def set_current_question
    # We don't need to set next question
    # if we've hit time limit
    return if persisted? && timed_out?

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
