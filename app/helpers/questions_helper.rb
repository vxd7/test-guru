module QuestionsHelper
  def question_header(action, test)
    case action
    when 'create'
      "Create new '#{test.title}' question"
    when 'edit'
      "Edit '#{test.title}' question"
    end
  end
end
