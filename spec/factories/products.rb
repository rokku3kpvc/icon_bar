FactoryBot.define do
  factory :product do
    name { FFaker::Product.product }
    price { rand(1000) }
    association :category
  end
end

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  price       :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           indexed
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#
