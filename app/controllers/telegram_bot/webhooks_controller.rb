module TelegramBot
  class WebhooksController < Telegram::Bot::UpdatesController
    def ping!(*)
      respond_with :message, text: t('.content')
    end
  end
end
