describe TelegramBot::WebhooksController, :telegram_bot do
  include_context('when user is authenticated')

  describe '#start!' do
    subject(:start) { -> { dispatch_command :start } }

    context 'when user is admin' do
      before do
        allow_any_instance_of(User).to receive(:admin?).and_return(true)
      end

      it 'responds with main menu' do
        expect(&start).to respond_with_message I18n.t('telegram_bot.texts.main_menu_info')
        expect(keyboard.size).to eq(3)
      end
    end

    context 'when user is not admin' do
      it 'responds with main and admin menu' do
        expect(&start).to respond_with_message I18n.t('telegram_bot.texts.main_menu_info')
        expect(keyboard.size).to eq(2)
      end
    end
  end

  describe '#ping!' do
    subject(:ping) { -> { dispatch_command :ping } }

    it 'responds with Pong! message' do
      expect(&ping).to respond_with_message 'Pong!'
    end
  end

  describe '#message' do
    describe 'admin_panel' do
      subject(:admin_panel) { -> { dispatch_message '⚙️ Админ панель' } }

      it 'responds with admin menu' do
        expect(&admin_panel).to respond_with_message '⚙️ Админ панель'
        expect(inline_keyboard.size).to eq(1)
      end
    end
  end

  describe '#callback_query', :callback_query do
    let(:data) { { command: command, data: callback_data.to_json }.to_json }

    describe 'manage_carte' do
      let(:command) { 'manage_carte' }
      let(:callback_data) { {} }
      let!(:product) { create(:product) }

      it { is_expected.to respond_with_message '⬇️⬇️ Барная карта ⬇️⬇️' }
      it { is_expected.to respond_with_message "Категория: #{product.category.name}\nНаименование: #{product.name}\nЦена: #{product.price}₽" }
    end
  end
end
