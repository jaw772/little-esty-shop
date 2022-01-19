class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = Discount.all
    facade = HeaderFacade.new
    @days = facade.usa.take(3)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.update(discount_params)
    if discount.save
      redirect_to "/merchants/#{merchant.id}/discounts/#{discount.id}",  notice: "Discount Successfully Updated"
    else
      redirect_to "/merchants/#{merchant.id}/discounts/#{discount.id}/edit", alert: "Your discount rate is incorrect"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.create()
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.discounts.create(discount_params)
    if discount.save
      redirect_to "/merchants/#{merchant.id}/discounts"
    else
      redirect_to "/merchants/#{merchant.id}/discounts/new", alert: "Your discount rate is incorrect"
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to "/merchants/#{merchant.id}/discounts"
  end

  private

  def discount_params
    params.require(:discount).permit(:name, :discount_rate, :threshold_quantity)
  end
end
