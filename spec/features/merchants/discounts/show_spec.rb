require 'rails_helper'

RSpec.describe "Merchant Discounts Show page" do

  it "has the discount name as a header and the attributes of the discount" do
    merchant = create(:merchant)
    discount = create(:discount, merchant: merchant, discount_rate: 0.3, threshold_quantity: 30, name: "30 For 30")

    visit "/merchants/#{merchant.id}/discounts/#{discount.id}"

    expect(page).to have_content("30 For 30")
    expect(page).to have_content("Percentage Discount: 30.0%")
    expect(page).to have_content("Quantity Threshold: 30")
  end
end 
