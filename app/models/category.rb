class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  def self.show_carte
    carte_text = ''
    includes(:products).all.map do |c|
      carte_text += "`#{c.name.upcase}`:\n"
      c.products.each do |p|
        carte_text += "#{p.name} - #{p.price}₽\n"
      end

      carte_text += "\n"
    end

    carte_text
  end

  def to_inline_button
    [{ text: name, callback_data: { command: Commands::OPEN_CATEGORY, data: { category_id: id } }.to_json }]
  end
end

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
