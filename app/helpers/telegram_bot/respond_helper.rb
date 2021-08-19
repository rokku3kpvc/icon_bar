module TelegramBot
  module RespondHelper
    include MenuStorage

    def respond_with_main_menu(text = 'Главное меню')
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

    def admin_panel
      respond_with :message, text: t('telegram_bot.texts.show_admin_menu'), reply_markup: {
        inline_keyboard: admin_menu
      }
    end

    def manage_carte
      respond_with_carte_header

      products = Product.all.map(&:to_inline_response)
      products.each { |p| respond_with(:message, **p) }

      answer_callback_ok
    end

    private

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
