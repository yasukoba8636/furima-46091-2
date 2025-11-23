class ItemsController < ApplicationController
  # ログインしていないユーザーは出品ページへ行けないようにする
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:show]


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

  #def move_to_index
    #redirect_to root_path unless current_user.id == @item.user_id
  #end

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

