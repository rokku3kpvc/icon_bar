module Authentication
  def current_user
    @current_user ||= find_user!
  end

  def current_order
    @current_order ||= find_order
  end

  alias authenticate_user current_user

  private

  def find_order
    order = current_user.orders.includes(:order_items, :products).find_by(state: 'opened')
    order.nil? ? current_user.create_empty_order('regular') : order
  end

  def find_user!
    User.find_by!(telegram_id: from.id)
  rescue ActiveRecord::RecordNotFound
    User.create_from_payload(from)
  end
end
