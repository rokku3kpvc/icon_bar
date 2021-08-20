module TelegramBot
  class WebhooksController < BaseController
    include RespondHelper
    include MessageHandler

    def start!(*)
      respond_with_main_menu
    end

    def ping!(*)
      respond_with :message, text: t('.content')
    end

    def message(payload)
      # TODO: научиться разделять админ команды
      command = handle_message(payload.text)
      method(command).call
    end

    # TODO: разделить callback_query в context. https://github.com/telegram-bot-rb/telegram-bot#callback-queries
    def callback_query(data)
      data = CallbackData.new(data)
      # TODO: научиться разделять админ команды
      method(data.command).call(data)
    end
  end
end
