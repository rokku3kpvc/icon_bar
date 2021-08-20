FactoryBot.define do
  factory :order do
    association :user
    total_price { 0 }
    kind { 'regular' }
    state { 'opened' }
  end
end

# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           indexed
#  total_price :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  kind        :enum             default("regular"), not null
#  state       :enum             default("opened"), not null
#  deposit_id  :bigint           indexed
#
# Indexes
#
#  index_orders_on_deposit_id  (deposit_id)
#  index_orders_on_user_id     (user_id)
#
