describe User, type: :model do
  describe '#admin?' do
    let!(:user) { create(:user, telegram_id: 1) }

    context 'when user is admin' do
      before do
        allow(Settings).to receive(:admin_ids).and_return([1])
      end

      it 'returns true' do
        expect(user.admin?).to eq(true)
      end
    end

    context 'when user is not admin' do
      it 'returns false' do
        expect(user.admin?).to eq(false)
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                      :bigint           not null, primary key
#  telegram_id             :bigint           not null, indexed
#  is_bot                  :boolean          default(FALSE), not null
#  first_name              :string
#  last_name               :string
#  username                :string
#  language_code           :string
#  supports_inline_queries :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
# Indexes
#
#  index_users_on_telegram_id  (telegram_id) UNIQUE
#
