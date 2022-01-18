require 'rails_helper'

RSpec.describe 'Merchant Items Show page' do
  it 'displays the item attributes' do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1)
    visit "/merchants/#{merchant_1.id}/items"

    click_on item_1.name
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(item_1.description)
    expect(page).to have_content(item_1.unit_price)
  end

  it 'allows the merchant to update their items' do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1, unit_price: 77777)
    visit "/merchants/#{merchant_1.id}/items/#{item_1.id}"
    expect(page).to have_link("Update #{item_1.name}")
    click_on("Update #{item_1.name}")
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}/edit")
    expect(page).to have_field(:item_unit_price, with: 77777)

    within("#update_item") do
      fill_in 'item_unit_price', with: 11111
      click_on 'Update Item'
    end
    expect(current_path).to eq("/merchants/#{merchant_1.id}/items/#{item_1.id}")
    #checking for flash message
    expect(page).to have_content("Item Successfully Updated")
  end

  it 'shows the total revenue from this invoice and the total discounted revenue' do
    merchant_1 = create(:merchant)
    item_1 = create(:item, merchant: merchant_1, unit_price: 77777)
    visit "/merchants/#{merchant_1.id}/items/#{item_1.id}"

end
