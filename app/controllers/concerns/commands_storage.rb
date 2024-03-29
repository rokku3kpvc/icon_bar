class CommandsStorage
  # Синглтон класс, предназначенный для хранения мапы вида "текст кнопки" => :command
  # где :command -- название метода WebhooksController, через который в последствии идёт вызов
  include Singleton

  class KeyError < ::StandardError; end

  attr_reader :commands_map

  def self.instance
    @instance ||= new
  end

  def initialize
    @commands_map = {}
    @commands_map[I18n.t('telegram_bot.texts.show_admin_menu')] = Commands::ADMIN_PANEL
    @commands_map[I18n.t('telegram_bot.texts.create_order')] = Commands::NEW_ORDER
    @commands_map[I18n.t('telegram_bot.texts.show_carte')] = Commands::SHOW_CARTE
  end

  def find_command_by_key(key)
    command = commands_map[key]
    raise KeyError if command.nil?

    command
  end
end
