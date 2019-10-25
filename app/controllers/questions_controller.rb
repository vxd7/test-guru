class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create new]
  before_action :find_question, only: %i[edit show update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found

  def index; end

  def show
    render plain: @question.inspect
  end

  def new
    @question = @test.questions.new
  end

  def create
    @question = @test.questions.new(question_params)

    if @question.save
      redirect_to @test
    else
      render :new
    end
  end

  def destroy
    if @question.destroy
      redirect_to @question.test
    else
      render :edit
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question.test
    else
      render :edit
    end
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
