class TestPassagesController < ApplicationController
  before_action :set_test_passage, only: %i[show update result gist]

  def show
  end

  def result
    # Check user badges when the test is finished
    @badges = check_badges

    # And save badges if there are any
    current_user.badges << @badges
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
                                     octokit_client).call

    user_gist = @test_passage.current_question.gists.new(gist_params(result))

    flash_options = if result.success? && user_gist.save!
                      gist_link = helpers.link_to t('.gist_link'),
                                                  result.html_url,
                                                  target: :_blank

                      { notice: [t('.success'), gist_link].join('<br>') }
                    else
                      { notice: t('.failure') }
                    end

    redirect_to @test_passage, flash_options
  end

  private

  def check_badges
    BadgesService.new(current_user, @test_passage.test).check_all_rules
  end

  def octokit_client
    Octokit::Client.new(access_token: Rails.application.credentials.github_token)
  end

  def gist_params(result)
    { user: @test_passage.user, url: result.html_url }
  end

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
