require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'enums validation' do
    it {should define_enum_for(:status).with([:pending, :packaged, :shipped])}
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity)}
    it { should validate_numericality_of(:quantity)}
    it { should validate_presence_of(:unit_price)}
    it { should validate_numericality_of(:unit_price)}
  end

  describe 'instance methods' do
    describe 'potential_revenue' do
      it "multiplies unit_price and quantity" do
        invoice_item = create(:invoice_item, quantity: 3, unit_price: 1000)
        expect(invoice_item.potential_revenue).to eq(3000)
      end
    end
  end
end
