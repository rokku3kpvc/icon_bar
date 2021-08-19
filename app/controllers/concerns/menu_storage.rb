module MenuStorage
  def admin_menu
    [
      [{ text: '🖍 Управлять барной картой', callback_data: { command: Commands::ADMIN_MANAGE_CARTE }.to_json }],
      [{ text: '🖌 Управлять депозитами', callback_data: { command: Commands::ADMIN_MANAGE_DEPOSITS }.to_json }],
      [{ text: '📈 Запросить отчётность', callback_data: { command: Commands::ADMIN_GENERATE_REPORT }.to_json }]
    ]
  end
end
