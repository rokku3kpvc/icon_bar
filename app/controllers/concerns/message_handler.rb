module MessageHandler
  # Обертка под CommandsStorage для удобного хранения инстанса и его инжект в контроллер
  def handle_message(text)
    storage.find_command_by_key(text)
  end

  private

  def storage
    @storage ||= CommandsStorage.instance
  end
end
