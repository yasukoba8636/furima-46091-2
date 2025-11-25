def create
  @order_shipping = OrderShipping.new(order_shipping_params)
  if @order_shipping.valid?
    pay_item
    @order_shipping.save
    redirect_to root_path
  else
    render :index, status: :unprocessable_entity
  end
end

private

def order_shipping_params
  params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :addresses, :building, :phone_number)
        .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
end

def pay_item
  Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  Payjp::Charge.create(
    amount: Item.find(params[:item_id]).price,
    card: order_shipping_params[:token],
    currency: 'jpy'
  )
end
