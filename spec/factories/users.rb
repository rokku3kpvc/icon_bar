FactoryBot.define do
  factory :user do
    sequence(:telegram_id, 1)
    is_bot { false }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    username { FFaker::Internet.user_name }
    language_code { 'ru' }
    supports_inline_queries { false }
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
