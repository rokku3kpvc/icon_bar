describe TelegramBot::WebhooksController, :telegram_bot do
  include_context('when user is authenticated')

  describe '#start!' do
    subject(:start) { -> { dispatch_command :start } }

    context 'when user is admin' do
      before do
        allow_any_instance_of(User).to receive(:admin?).and_return(true)
      end

      it 'responds with main menu' do
        expect(&start).to respond_with_message 'Главное меню'
        expect(keyboard.size).to eq(4)
      end
    end

    context 'when user is not admin' do
      it 'responds with main and admin menu' do
        expect(&start).to respond_with_message 'Главное меню'
        expect(keyboard.size).to eq(3)
      end
    end
  end

  describe '#ping!' do
    subject(:ping) { -> { dispatch_command :ping } }

    it 'responds with Pong! message' do
      expect(&ping).to respond_with_message 'Pong!'
    end
  end
end
