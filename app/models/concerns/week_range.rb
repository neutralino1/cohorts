module Concerns::WeekRange
  extend ActiveSupport::Concern
  included do
    def start_date
      @start_date ||= pdt_time Date.commercial(year, week, 1)
    end

    def end_date
      @end_date ||= pdt_time Date.commercial(year, week, 7)
    end

    def time_range
      start_date..end_date.end_of_day
    end

    private

    def pdt_time dt
      Time.zone.local(dt.year, dt.month, dt.day)
    end

    def id
      "#{year}-#{week}"
    end

    def is_current_week?
      t = Time.zone.now
      t.year == year && t.strftime("%V").to_i == week
    end
  end
end