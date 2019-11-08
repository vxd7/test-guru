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
    user_gist = Gist.create_gist(@test_passage)
    if user_gist
      gist_link = helpers.link_to t('.gist_link'), user_gist.url,
                                  target: :_blank
      flash_options = { notice: [t('.success'), gist_link].join('<br>') }
    else
      flash_options = { notice: t('.failure') }
    end

    redirect_to @test_passage, flash_options
  end

  private

  def set_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end
