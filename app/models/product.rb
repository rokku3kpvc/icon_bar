class Product < ApplicationRecord
  belongs_to :category
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  def to_inline_response
    {
      text: "Категория: #{category.name}\nНаименование: #{name}\nЦена: #{price}₽",
      reply_markup: {
        inline_keyboard: [
          to_inline_button('🔧 Редактировать', Commands::ADMIN_EDIT_PRODUCT.to_s),
          to_inline_button('❌ Удалить', Commands::ADMIN_DESTROY_PRODUCT.to_s)
        ]
      }
    }
  end

  def to_order_up_button(current_order)
    amount = current_order.order_items.where(product_id: id).count

    [{
      text: "(#{amount}) #{name}", callback_data: { command: Commands::APPEND_PRODUCT, data: { product_id: id } }.to_json
    }]
  end

  def to_order_down_buttons
    [
      {
        text: '◀️', callback_data: { command: Commands::REDUCE_PRODUCT, data: { product_id: id } }.to_json
      },
      {
        text: '▶️️', callback_data: { command: Commands::APPEND_PRODUCT, data: { product_id: id } }.to_json
      }
    ]
  end

  private

  def to_inline_button(text, command)
    [{
      text: text,
      callback_data: { command: command, data: { id: id } }.to_json
    }]
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
