describe Product, type: :model do
  describe '#to_inline_response' do
    let!(:product) { create(:product) }
    let!(:response) do
      {
        text: "Категория: #{product.category.name}\nНаименование: #{product.name}\nЦена: #{product.price}₽",
        reply_markup: {
          inline_keyboard: [
            [{ text: '🔧 Редактировать', callback_data: { command: :edit_product, data: { id: product.id } }.to_json }],
            [{ text: '❌ Удалить', callback_data: { command: :destroy_product, data: { id: product.id } }.to_json }]
          ]
        }
      }
    end

    it 'generates valid telegram inline response' do
      expect(product.to_inline_response).to eq(response)
    end
  end
end

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  price       :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           indexed
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#
