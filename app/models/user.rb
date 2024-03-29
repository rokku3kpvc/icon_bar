class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  def self.create_from_payload(payload)
    create(
      telegram_id: payload.id,
      is_bot: payload.is_bot,
      first_name: payload.first_name,
      last_name: payload.last_name,
      username: payload.username,
      language_code: payload.language_code,
      supports_inline_queries: payload.supports_inline_queries
    )
  end

  def create_empty_order(kind, deposit_id = nil)
    orders.create(
      total_price: 0,
      kind: kind,
      state: 'opened',
      deposit_id: deposit_id
    )
  end

  def admin?
    Settings.admin_ids.include?(telegram_id)
  end
end

# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  telegram_id             :bigint           not null, indexed
#  is_bot                  :boolean          default(FALSE), not null
#  first_name              :string
#  last_name               :string
#  username                :string
#  language_code           :string
#  supports_inline_queries :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_telegram_id  (telegram_id) UNIQUE
#
