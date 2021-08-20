module MenuStorage
  def admin_menu
    [
      # [{ text: '🖍 Управлять барной картой', callback_data: { command: Commands::ADMIN_MANAGE_CARTE }.to_json }],
      # TODO: вернуть депозиты и отчетность когда доделаю
      # [{ text: '🖌 Управлять депозитами', callback_data: { command: Commands::ADMIN_MANAGE_DEPOSITS }.to_json }],
      # [{ text: '📈 Запросить отчётность', callback_data: { command: Commands::ADMIN_GENERATE_REPORT }.to_json }]
    ]
  end

  def inline_move_back_buttons(move_back_command)
    [
      { text: '↩️️ Назад️', callback_data: { command: move_back_command }.to_json },
      { text: '❌ Отмена️', callback_data: { command: Commands::RETURN_TO_MAIN_MENU }.to_json }
    ]
  end

  def confirm_button(command)
    [
      { text: '✅️️ Подтвердить', callback_data: { command: command }.to_json }
    ]
  end
end
