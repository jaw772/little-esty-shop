require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
    it { should have_many(:transactions).through(:invoice)}
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

  describe 'class methods' do
      describe 'revenue' do
      it "multiplies unit_price and quantity for a collection of invoice_items and sums them only if they are associated with an invoice that has at least 1 successful transaction" do
        invoice_1 = create(:invoice)
        invoice_2 = create(:invoice)
        invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 1000, invoice: invoice_1)
        invoice_item_2 = create(:invoice_item, quantity: 5, unit_price: 1000, invoice: invoice_1)
        invoice_item_3 = create(:invoice_item, quantity: 1, unit_price: 1000, invoice: invoice_2)
        invoice_items = InvoiceItem.where(id:[invoice_item_1.id, invoice_item_2.id, invoice_item_3.id])

        # these invoice_items should not be included in any potential revenue
        invoice_3 = create(:invoice)
        invoice_item_4 = create(:invoice_item, quantity: 1, unit_price: 1000, invoice: invoice_3)
        transaction = create(:transaction, result: 0, invoice: invoice_3)

        # test for no transactions
        expect(invoice_items.revenue).to eq(0)

        # test for no successful transactions.
        transaction_1 = create(:transaction, result: 1, invoice: invoice_1)
        expect(invoice_items.revenue).to eq(0)

        # test for successful transactions
        transaction_2 = create(:transaction, result: 0, invoice: invoice_1)
        expect(invoice_items.revenue).to eq(8000)

        # test for multiple invoices with successful transactions
        transaction_3 = create(:transaction, result: 0, invoice: invoice_2)
        expect(invoice_items.revenue).to eq(9000)
      end
    end
  end

  describe 'instance methods' do
    describe '#find_discount' do
      it 'returns the best discount available for a given invoice_item' do
        merchant_1 = create(:merchant)
        invoice_1 = create(:invoice)
        transaction = create(:transaction, invoice: invoice_1, result: 0)
        discount_1 = create(:discount, merchant: merchant_1, threshold_quantity: 10, discount_rate: 0.1)
        discount_2 = create(:discount, merchant: merchant_1, threshold_quantity: 20, discount_rate: 0.2)
        invoice_item_1 = create(:invoice_item, quantity: 22, invoice: invoice_1)

        expect(invoice_item_1.find_discount(merchant_1)).to eq(discount_2)
      end
    end
  end
end
