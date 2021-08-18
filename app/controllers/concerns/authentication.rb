module Authentication
  def current_user
    @current_user ||= find_user!
  end

  alias authenticate_user current_user

  private

  def find_user!
    User.find_by!(telegram_id: from.id)
  rescue ActiveRecord::RecordNotFound
    User.create_from_payload(from)
  end
end
