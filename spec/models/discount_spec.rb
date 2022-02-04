require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'associations' do
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:discount_rate) }
  end
end
