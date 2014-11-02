class HomeController < ApplicationController

  def index
    params[:nweeks] = nil if params[:nweeks].try(:strip).try(:blank?)
    params[:nweeks] = all_weeks if params[:all].to_i == 1
    @nweeks = params[:nweeks].try(:to_i) || CohortBuilder::DEFAULT_BACK_WEEKS
    # to_i on nil is 0, we don't want that, we want nil
    @cohorts = CohortBuilder.build_weekly_cohorts(@nweeks)
  end

  private

  def all_weeks
    ((User.last.created_at - User.first.created_at) / 3600 / 24 / 7).ceil
  end

end