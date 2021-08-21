module TelegramBot
  module RespondHelper
    include MenuStorage

    # TODO: надо вынестир работу с базой, подсчеты и другую логику в отдельный DSL

    def respond_with_main_menu(text = t('telegram_bot.texts.main_menu_info'))
      keyboard = if current_user.admin?
                   (t('telegram_bot.main_menu') + t('telegram_bot.buttons.admin'))
                 else
                   t('telegram_bot.main_menu')
                 end

      respond_with :message, text: text, reply_markup: {
        keyboard: keyboard,
        resize_keyboard: true
      }
    end

    # == REGULAR KEYBOARD COMMANDS ==

    def admin_panel
      respond_with :message, text: t('telegram_bot.texts.show_admin_menu'), reply_markup: {
        inline_keyboard: admin_menu
      }
    end

    def new_order
      if current_order.deposit?
        current_order.update(kind: 'regular', deposit_id: nil)
      end

      category_buttons = Category.all.map(&:to_inline_button)

      respond_with :message, text: new_order_page_text, reply_markup: {
        inline_keyboard: category_buttons
      }
    end

    def chow_carte
      respond_with :message, text: Category.show_carte, parse_mode: :Markdown
    end

    # == INLINE KEYBOARD COMMANDS ==

    def generate_report(_callback_data)
      text_report = OrderReport.new.generate

      respond_with :message, text: text_report, parse_mode: :Markdown
      answer_callback_ok
    end

    def return_to_category_list(_callback_data)
      delete_last_message
      new_order
      answer_callback_ok
    end

    def return_to_main_menu(callback_data)
      current_order.reset
      return_to_category_list(callback_data)
    end

    def manage_carte(_callback_data)
      respond_with_carte_header

      products = Product.all.map(&:to_inline_response)
      products.each { |p| respond_with(:message, **p) }

      answer_callback_ok
    end

    def open_category(callback_data)
      product_buttons = []
      Category.find(callback_data.data[:category_id]).products.each do |p|
        product_buttons.append(p.to_order_up_button(current_order))
        product_buttons.append(p.to_order_down_buttons)
      end

      keyboard = product_buttons
                 .append(inline_move_back_buttons(Commands::RETURN_TO_CATEGORY_LIST))
                 .append(confirm_button(Commands::CREATE_ORDER))

      delete_last_message
      respond_with :message, text: new_order_page_text(with_info: false), reply_markup: {
        inline_keyboard: keyboard
      }

      answer_callback_ok
    end

    def append_product(callback_data)
      product = Product.find(callback_data.data[:product_id])
      current_order.add_product(product)

      return_to_category(callback_data, product.category_id)
    end

    def reduce_product(callback_data)
      product = Product.find(callback_data.data[:product_id])
      order_item = current_order.order_items.find_by(product_id: product.id)

      if order_item.present?
        order_item.destroy
      end

      return_to_category(callback_data, product.category_id)
    end

    def create_order(callback_data)
      result = current_order.confirm_order
      if result != 'ok'
        return_to_category_list(callback_data)
        return
      end

      delete_last_message
      send_successful_order_message
      respond_with_main_menu
      answer_callback_ok
    end

    private

    def send_successful_order_message
      text = "✅ Заказ №#{current_order.id} успешно сформирован\n"
      text += current_order.to_text

      respond_with :message, text: text
    end

    def new_order_page_text(with_info: true)
      create_order_text = t('telegram_bot.texts.create_order')
      new_order_info_text = t('telegram_bot.texts.new_order_info')

      if with_info
        create_order_text + new_order_info_text + current_order.to_text
      else
        "#{create_order_text}\n#{current_order.to_text}"
      end
    end

    def delete_last_message
      bot.delete_message(chat_id: payload.from.id, message_id: payload.message.message_id)
    end

    def return_to_category(callback_data, category_id)
      callback_data.data[:category_id] = category_id
      open_category(callback_data)
    end

    def respond_with_carte_header
      respond_with :message, text: '⬇️⬇️ Барная карта ⬇️⬇️', reply_markup: {
        inline_keyboard: [[{ text: 'Добавить позицию', callback_data: { command: Commands::ADMIN_CREATE_PRODUCT }.to_json }]]
      }
    end

    def answer_callback_ok
      answer_callback_query 'Успешно'
    end
  end
end
