class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create new]
  before_action :find_question, only: %i[edit show update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index
    render plain: @test.questions.inspect
  end

  def show
    render plain: @question.inspect
  end

  def new; end

  def create
    @test.questions.create(question_params)

    render plain: 'Successfully created question!'
  end

  def destroy
    @question.destroy

    render plain: 'Successfullt deleted question!'
  end

  private

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:content)
  end

  def rescue_with_question_not_found
    render plain: 'Question not found'
  end
end
