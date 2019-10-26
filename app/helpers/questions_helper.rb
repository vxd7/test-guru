module QuestionsHelper
  def question_header(question)
    if question.new_record?
      "Create new '#{question.test.title}' question"
    elsif question.persisted?
      "Edit '#{question.test.title}' question"
    end
  end
end
