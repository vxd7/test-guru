class TestsController < ApplicationController
  before_action :find_test, only: %i[start]

  def index
    @tests = Test.all
  end

  def show; end

  def start
    user = current_user
    user.tests.push(@test)
    redirect_to user.test_passage(@test)
  end

  private

  def find_test
    @test = Test.find(params[:id])
  end
end
