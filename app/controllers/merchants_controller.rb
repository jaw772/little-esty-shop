class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end
  def new
    @merchant = Merchant.create()
  end
  def create
  end
  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
