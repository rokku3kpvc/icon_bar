class OrderQuery < BaseQuery
  def initialize(**params)
    @query = Order.confirmed.all
    @params = params
  end

  def execute
    @query = for_specific_period
  end

  private

  def for_specific_period
    from = params[:from].presence || Utils::Calendar.saturday
    till = params[:till].presence || (Utils::Calendar.saturday + 1.day).end_of_day

    query.where(updated_at: from..till)
  end
end
