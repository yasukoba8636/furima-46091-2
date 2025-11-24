class ItemsController < ApplicationController
  # ログインしていないユーザーは出品ページへ行けないようにする
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index_unless_seller, only: [:edit, :update]
  before_action :sold_out_item, only: [:edit]

  # トップページ
  def index
     @items = Item.order(created_at: :desc)
  end

  # 出品ページ表示
  def new
    @item = Item.new
  end

  def show  
  end

  def edit
  
  end

  def update
  if @item.update(item_params)
    redirect_to item_path(@item), notice: "商品情報を更新しました"
  else
    render :edit, status: :unprocessable_entity
  end
end


  def move_to_index
    redirect_to root_path unless current_user.id == @item.user_id
  end

  # 出品処理
  def create
    @item = Item.new(item_params)
    @item.user = current_user  # 出品者情報を紐づけ

    if @item.save
        redirect_to root_path, notice: "商品を出品しました"
    else
      render :new, status: :unprocessable_entity  # エラー時は出品ページに戻る
    end
  end

  def destroy
  @item = Item.find(params[:id])

  if current_user.id == @item.user_id
    @item.destroy
    redirect_to root_path, notice: "商品を削除しました"
  else
    redirect_to root_path, alert: "削除権限がありません"
  end
end

  def sold_out_item
  redirect_to root_path if @item.order.present?
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  # Strong Parameters（許可するカラムを明示）
  def item_params
    params.require(:item).permit(
    :name, :description, :category_id, :condition_id, :shipping_fee_id,
    :prefecture_id,:shipping_day_id, :price, :image 
    )
    end
  end

