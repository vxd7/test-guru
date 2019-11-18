class BadgesService
  # Here we define all avaliable badge criteria as method names
  RULES = %i[passed_all_tests_by_category? passed_all_lvl_tests?
             passed_test_first_try?].freeze

  def initialize(user, current_finished_test)
    @user = user
    @current_finished_test = current_finished_test
  end

  def check_all_rules
    # Check all rules for registered badges
    Badge.all.select do |badge|
      send(badge.rule, badge)
    end
  end

  def passed_test_first_try?(_)
    user_test_passage_count = @user.test_passages.where(success: true)
                                   .joins(:test)
                                   .where('tests.id = ?', @current_finished_test.id)
                                   .count
    user_test_passage_count == 1
  end

  # Note: this badge can be earned multiple times.
  def passed_all_tests_by_category?(badge)
    category = badge.value
    return false unless correct_category?(@current_finished_test, category)

    category_id = @current_finished_test.category.id

    # Get the date of the latest badge with this rule and category value
    # which belong to the user '@user'
    latest_category_badge_date = latest_badge_date(@user, badge.rule, category)

    # Select tests which user passed after the date of last badge of this category
    # and get passages distinct by test name
    user_test_passages_grouped = @user.test_passages
                                      .where(success: true)
                                      .where('test_passages.created_at > ?', latest_category_badge_date)
                                      .joins(:test)
                                      .where('tests.category_id = ?', category_id)
                                      .distinct(:title)

    all_category_tests = Test.tests_by_category(category)

    # User did finish all the 'category' tests
    user_test_passages_grouped.count == all_category_tests.count
  end

  def passed_all_lvl_tests?(badge)
    lvl = badge.value
    return false unless correct_level?(@current_finished_test, lvl)

    user_test_passages_by_lvl = @user.test_passages.where(success: true).joins(:test)
                                     .where('tests.level = ?', lvl)
                                     .group(:test_id).count

    all_lvl_tests = Test.where(level: lvl)

    return false if user_test_passages_by_lvl.count != all_lvl_tests.count

    user_test_passages_by_lvl.values.uniq.count == 1
  end

  def self.avaliable_rules
    RULES
  end

  private

  def correct_category?(test, category)
    test.category.name == category
  end

  def correct_level?(test, level)
    test.level == level
  end

  # Get the date user has earned the latest badge
  # with the value 'value'
  def latest_badge_date(user, rule, value)
    # Get the latest badge of this value
    latest_badge = user.user_badges.joins(:badge)
                       .where('badges.rule = ?', rule)
                       .where('badges.value = ?', value)
                       .order(created_at: :desc).first

    return 0 if latest_badge.nil?

    latest_badge.created_at
  end
end
