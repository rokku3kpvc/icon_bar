module TelegramBot
  class BaseController < Telegram::Bot::UpdatesController
    include Telegram::Bot::UpdatesController::TypedUpdate
    include Authentication

    before_action :authenticate_user
  end
end
