class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  enum status: { "in progress": 0, cancelled: 1, completed: 2}

  def customer_name
    (customer.first_name) + " " + (customer.last_name)
  end

  def merchant_items(merchant)
    Item.joins(:invoice_items).where( items: {merchant_id: merchant.id})
  end

  def merchant_invoice_items(merchant)
    invoice_items.joins(:item).where( items: {merchant_id: merchant.id}).order("items.name asc")
  end

  def revenue
    invoice_items.revenue
  end

  def revenue_by_merchant(merchant)
    merchant_invoice_items(merchant).revenue
  end

  def discounted_revenue(merchant)
    total = 0
    if merchant.discounts.count == 0
      total
    else
      merchant_invoice_items(merchant).each do |inv_item|
        discount = inv_item.find_discount(merchant)
        if discount == nil
          total
        else
          total += (discount.discount_rate * (inv_item.quantity * inv_item.unit_price)).to_i
        end
      end
      total
    end
  end

  def admin_discounted_revenue
    total = 0
    invoice_items.each do |inv_item|
      item = Item.find(inv_item.item_id)
      merchant = Merchant.find(item.merchant_id)
      total += discounted_revenue(merchant)
    end
    total
  end

  def admin_total_discounted_revenue
    revenue - admin_discounted_revenue
  end

  def merchant_total_discounted_revenue(merchant)
    revenue_by_merchant(merchant) - discounted_revenue(merchant)
  end
end
