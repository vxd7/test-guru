module TestsHelper
  def test_header(test)
    if test.new_record?
      'Create new test'
    elsif test.persisted?
      "Edit test '#{test.title}'"
    end
  end
end
