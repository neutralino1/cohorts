class Week < Struct.new(:cohort, :year, :week)

  include Concerns::WeekRange
  include ActiveModel::Conversion
  
  def cache_key
    @cache_key ||= "#{cohort.cache_key}:week:#{id}"
  end

  def orderers_count
    @orderers_count ||= Rails.cache.fetch("#{cache_key}:orderers_count", force: is_current_week?) do
      orderers.count
    end
  end

  def orderers
    @orderers ||= cohort.users.joins(:orders).where(orders: {created_at: time_range})
  end

  def first_time_orderers_count
    @first_time_orderers_count ||= Rails.cache.fetch("#{cache_key}:first_time_orderers_count", force: is_current_week?) do
      first_time_orderers.count
    end
  end

  def first_time_orderers
    @first_time_orderers ||= cohort.users.joins(:orders).where(orders: {created_at: time_range, order_num: 1})
  end

end