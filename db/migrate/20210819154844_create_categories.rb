class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.timestamps
    end

    add_reference :products, :category
  end
end
