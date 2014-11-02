class Cohort < Struct.new(:year, :week)

  include Concerns::WeekRange
  include ActiveModel::Conversion

  def users_count
    @users_count ||= Rails.cache.fetch("#{cache_key}:users_count", force: is_current_week?) do
      users.count
    end
  end

  def users
    @users ||= User.where(created_at: time_range)
  end

  def weeks
    @weeks ||= compute_weeks
  end

  def cache_key
    @cache_key ||= "cohort:#{id}"
  end

  private

  def compute_weeks
    _weeks = []
    date = Date.commercial(year, week, 1)
    begin
      _weeks << Week.new(self, date.year, date.strftime("%V").to_i)
      date += 1.week
    end until date >= CohortBuilder::END_DATE
    _weeks
  end

end