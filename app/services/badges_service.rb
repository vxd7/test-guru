class BadgesService
  # Here we define all avaliable badge criteria as method names
  RULES = ['passed_all_backend_tests?', 'passed_test_first_try?',
           'passed_all_lvl_1_tests?', 'passed_all_lvl_10_tests?'].freeze

  def passed_all_backend_tests?(user, current_finished_test)
    return false if current_finished_test.category_id = Category.find_by(name: 'Backend')

    passed_all_tests_by_category?(user, 'Backend')
  end

  def passed_all_lvl_1_tests?(user, current_finished_test)
    return false if current_finished_test.level != 1

    passed_all_lvl_tests(user, 1)
  end

  def passed_all_lvl_10_tests?(user, current_finished_test)
    return false if current_finished_test.level != 10

    passed_all_lvl_tests?(user, 10)
  end

  def passed_test_first_try?(user, current_finished_test)
    user_test_passage_count = user.test_passages.where(succes: true).joins(:tests)
                                  .where('tests.id = ?', current_finished_test.id)
                                  .count
    user_test_passage_count == 1
  end

  private

  # Note: this badge can be earned multiple times.
  def passed_all_tests_by_category?(user, category)
    category_id = Category.find_by(name: category).id

    # Get hash of the form: {test_id => number_of_successful_passes, ...}
    user_test_passages_grouped = user.test_passages.where(success: true).joins(:test)
                                     .where('tests.category_id = ?', category_id)
                                     .group(:test_id).count
    all_category_tests = Test.tests_by_category(category)

    # User did not finish all the 'category' tests
    return false if user_test_passages_grouped.count != all_category_tests.count

    # true if numbers of passages for every test is the same
    user_test_passages_grouped.values.uniq.count == 1
  end

  def passed_all_lvl_tests?(user, lvl)
    user_test_passages_by_lvl = user.test_passages.where(success: true).joins(:test)
                                    .where('tests.level = ?', lvl)
                                    .group(:test_id).count

    all_lvl_tests = Test.where(level: lvl)

    return false if user_test_passages_by_lvl.count != all_lvl_tests.count

    user_test_passages_by_lvl.values.uniq.count == 1
  end
end
