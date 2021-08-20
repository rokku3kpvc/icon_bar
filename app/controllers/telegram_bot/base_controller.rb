module TelegramBot
  class BaseController < Telegram::Bot::UpdatesController
    include Telegram::Bot::UpdatesController::TypedUpdate
    include Telegram::Bot::UpdatesController::MessageContext
    include CallbackQueryContext
    include Authentication

    cattr_reader :redis, default: Containers.redis

    before_action :authenticate_user, :current_order
  end
end
