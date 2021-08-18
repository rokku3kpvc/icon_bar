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
      command = handle_message(payload.text)
      method(command).call
    end
  end
end
