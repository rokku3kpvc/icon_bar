class User < ApplicationRecord
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

  def admin?
    Settings.admin_ids.include?(telegram_id)
  end
end

# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  telegram_id             :bigint           not null
#  is_bot                  :boolean          default(FALSE), not null
#  first_name              :string
#  last_name               :string
#  username                :string
#  language_code           :string
#  supports_inline_queries :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
