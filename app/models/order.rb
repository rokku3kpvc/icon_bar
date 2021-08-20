class Order < ApplicationRecord
  # TODO: заказ со статусом "открытый" может быть только один на пользователя.
  # хоть в текущей бизнес логике такого быть не может,
  # все же нужно добавить коллбек при сохранении, чтобы не создавать новый
  include AASM

  belongs_to :user
  belongs_to :deposit, optional: true
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  aasm column: :state do
    state :opened, initial: true
    state :confirmed

    event :confirm do
      transitions from: :opened, to: :confirmed
    end
  end

  def to_text
    return '' if products.reload.size.zero?

    text = "\nСостав заказа:\n"
    products.group(:name).count.each do |name, counts|
      text += "#{name} - #{counts} шт.\n"
    end

    text += "\nСумма заказа: #{total_price}₽\n"
    text
  end

  def regular?
    kind == 'regular'
  end

  def deposit?
    kind == 'deposit'
  end

  def add_product(product)
    products << product
    update(total_price: total_price + product.price)
  end

  def remove_product(product)
    order_item = order_items.find_by(product_id: product.id)

    if order_item.present?
      order_item.destroy
      update(total_price: total_price - product.price)
    end
  end

  def reset
    order_items.destroy_all
    update(total_price: 0)
  end

  # TODO: избавиться от elixir way в этом методе
  def confirm_order
    return 'error' if total_price <= 0

    confirm!
    'ok'
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
