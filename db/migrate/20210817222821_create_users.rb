class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.bigint      :telegram_id, null: false, unique: true
      t.boolean     :is_bot, null: false, default: false
      t.string      :first_name
      t.string      :last_name
      t.string      :username
      t.string      :language_code
      t.boolean     :supports_inline_queries
      t.timestamps
    end
  end
end
