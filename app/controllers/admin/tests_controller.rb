class Admin::TestsController < Admin::BaseController
  before_action :find_tests, only: %i[update_inline index]
  before_action :find_test, only: %i[show edit update destroy update_inline] # start

  def index; end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.authored_tests.create(test_params)

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

  # Update test title in admin table
  # inline
  def update_inline
    if @test.update(test_params)
      redirect_to admin_tests_path
    else
      render :index
    end
  end

  def destroy
    @test.destroy

    redirect_to admin_tests_path
  end

  private

  def find_tests
    @tests = Test.all
  end

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end
end
