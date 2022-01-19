require 'rails_helper'

RSpec.describe "Merchant Discounts Index page" do

  it "has the discount name as a link to the show page and the attributes of the discount" do
    merchant = create(:merchant)
    discount1 = create(:discount, merchant: merchant, discount_rate: 0.3, threshold_quantity: 30, name: "30 For 30")

    visit "/merchants/#{merchant.id}/discounts/"

    expect(page).to have_content("Percentage Discount: 30.0%")
    expect(page).to have_content("Quantity Threshold: 30")
    expect(page).to have_link("30 For 30")
  end

  it 'has a delete link next to each discount, then once clicked the discount is gone' do
    merchant = create(:merchant)
    discount1 = create(:discount, merchant: merchant, discount_rate: 0.3, threshold_quantity: 30, name: "30 For 30")

    visit "/merchants/#{merchant.id}/discounts/"

    expect(page).to have_link("Delete")
    click_on("Delete")
    expect(page).to_not have_content("30 For 30")
  end

  it 'displays a section with a header of the next 3 upcoming holidays' do
    visit "/merchants/#{merchant.id}/discounts/"

    expect(page).to have_content("Valentine's Day")
    expect(page).to have_content("St. Patricks Day")
    expect(page).to have_content("Easter")
  end 
end
