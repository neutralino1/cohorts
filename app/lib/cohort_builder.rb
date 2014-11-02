module CohortBuilder
  extend self
  DEFAULT_BACK_WEEKS = 8
  END_DATE = DateTime.new(2013, 7, 7).end_of_week

  def build_weekly_cohorts back_weeks = DEFAULT_BACK_WEEKS
    back_weeks ||= DEFAULT_BACK_WEEKS
    return [] if back_weeks.zero?
    start_date = (END_DATE - (back_weeks.weeks - 1)).beginning_of_week
    end_date = END_DATE
    cohorts = []
    begin
      cohorts << Cohort.new(end_date.year, end_date.strftime("%V").to_i)
      end_date -= 1.week
    end while end_date >= start_date
    cohorts
  end

end
