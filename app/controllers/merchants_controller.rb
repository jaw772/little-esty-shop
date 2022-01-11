class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end
  def new
    @merchant = Merchant.create()
  end
  def create
    # binding.pry
    merchant = Merchant.create!(merchant_params)
    redirect_to '/', notice: "Welcome #{merchant.username}!"
  end
  private

  def merchant_params
    params.require(:merchant).permit(:username, :password_digest, :name)
  end
end
