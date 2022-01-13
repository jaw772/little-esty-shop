require 'rails_helper'

RSpec.describe "Merchant Discount New page" do

  it "has a form for new discount, and redirects to merchant discounts index with new discount listed" do
    merchant = create(:merchant)
    visit "/merchants/#{merchant.id}/discounts/new"

    expect(page).to have_content("Add a new discount")
    fill_in ":name", with: "20 For 20"
    fill_in ":discount_rate", with: 0.20
    fill_in ":threshold_quantity", with: 20
    click_on "Create Discount"
    expect(current_path).to eq("/merchants/#{merchant1.id}/discounts")
  end
end 
