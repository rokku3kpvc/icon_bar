describe TelegramBot::WebhooksController, :telegram_bot do
  describe '#ping!' do
    subject(:ping) { -> { dispatch_command :ping } }

    it 'responds with Pong! message' do
      expect(&ping).to respond_with_message 'Pong!'
    end
  end
end
