require 'test_helper'

class CohortTest < ActiveSupport::TestCase

  def test_cache_key
    assert_equal 'cohort:2014-13', Cohort.new(2014, 13).cache_key
  end

  def test_users
    user = FactoryGirl.create(:user, created_at: Time.now)
    user2 = FactoryGirl.create(:user, created_at: 1.week.ago)
    t = Time.now
    cohort = Cohort.new(t.year, t.strftime("%V").to_i)
    assert cohort.users.include?(user)
    assert !cohort.users.include?(user2)
    assert_equal 1, cohort.users_count
  end

  def test_weeks
    
  end
end