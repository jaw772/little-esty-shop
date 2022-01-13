class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.create()
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.create(discount_params)
  end

  private

  def discount_params
    params.require(:discount).permit(:name, :discount_rate, :threshold_quantity)
  end 
end
