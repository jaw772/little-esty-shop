require 'rails_helper'

RSpec.describe "Merchant Discounts Edit page" do

  it "allowd merchant to update discount and fields are pre-filled" do
    merchant = create(:merchant)
    discount = create(:discount, merchant: merchant, discount_rate: 0.3, threshold_quantity: 30, name: "30 For 30")

    visit "/merchants/#{merchant.id}/discounts/#{discount.id}"
    click_on "Update #{discount.name}"
    expect(current_path).to eq("/merchants/#{merchant.id}/discounts/#{discount.id}/edit")
    expect(page).to have_field(:discount_discount_rate, with: 0.3)

    fill_in 'discount_discount_rate', with: 0.35
    click_on 'Update Discount'
    expect(current_path).to eq("/merchants/#{merchant.id}/discounts/#{discount.id}")
    #checking for flash message
    expect(page).to have_content("Discount Successfully Updated")
  end
end
