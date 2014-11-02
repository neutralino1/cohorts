module ApplicationHelper

  def cohort_time_range cohort
    "#{cohort.start_date.strftime('%m/%d')} - #{cohort.end_date.strftime('%m/%d')}"
  end

end
