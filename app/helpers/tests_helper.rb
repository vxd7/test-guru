module TestsHelper
  def test_header(test)
    if test.new_record?
      'Create new test'
    elsif test.persisted?
      "Edit test '#{test.title}'"
    end
  end

  def test_category(test)
    if test.category.nil?
      'Category not assigned'
    else
      test.category.name
    end
  end

  def tests_levels
    Test.order(:level).distinct(:level).pluck(:level)
  end
end
