class Admin::TestsController < Admin::BaseController
  before_action :find_test, only: %i[show edit update destroy] # start
  # before_action :set_user, only: :start

  def index
    @tests = Test.all
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = Test.create(test_params)
    @test.author = current_user

    if @test.save
      redirect_to admin_test_path(@test)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to admin_test_path(@test)
    else
      render :edit
    end
  end

  def destroy
    @test.destroy

    redirect_to admin_tests_path
  end

  # def start
  #   user = current_user
  #   user.tests.push(@test)
  #   redirect_to user.test_passage(@test)
  # end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  # def set_user
  #   @user = current_user
  # end
end
