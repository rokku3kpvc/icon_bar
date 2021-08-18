module TelegramBot
  module RespondHelper
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
        inline_keyboard: t('telegram_bot.admin_menu')
      }
    end
  end
end
