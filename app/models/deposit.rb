class Deposit < ApplicationRecord
end

# == Schema Information
#
# Table name: deposits
#
#  id               :bigint           not null, primary key
#  owners_name      :string           not null
#  primary_size     :integer          default(0), not null
#  accumulated_size :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
