class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :item_setter, only: [:index, :create]

  def index
    if current_user.id == @item.user_id || Order.exists?(item_id: @item.id)
      redirect_to root_path
    end
    @order_destination = OrderDestination.new
  end

  def create
    @order_destination = OrderDestination.new(order_params)
    if @order_destination.valid?
      pay_item
      @order_destination.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_setter
    @item = Item.find(params[:item_id])
  end


  def order_params
    params.require(:order_destination).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
