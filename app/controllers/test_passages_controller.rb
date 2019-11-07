class TestPassagesController < ApplicationController
  before_action :set_test_passage, only: %i[show update result gist]

  def show

  end

  def result
  end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@test_passage.current_question,
                                     client: octokit_client).call

    user_gist = @test_passage.current_question.gists.create(gist_params(result))

    flash_options = if user_gist.save
                      { notice: t('.success') }
                    else
                      { notice: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def octokit_client
    Octokit::Client.new(access_token: 'c6ed841aaf0fe3eeab01cfc05e47cff942f62da5')
  end

  def gist_params(gist_response)
    { user: @test_passage.user, url: gist_response['html_url'] }
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
