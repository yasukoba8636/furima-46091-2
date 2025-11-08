class ItemsController < ApplicationController
  # ログインしていないユーザーは出品ページへ行けないようにする
  before_action :authenticate_user!, only: [:new, :create]

  # トップページ
  def index
    # 商品一覧を表示したい場合、ここに @items = Item.all などを後で追加
  end

  # 出品ページ表示
  def new
    @item = Item.new
  end

  # 出品処理
  def create
    @item = Item.new(item_params)
    @item.user = current_user  # 出品者情報を紐づけ

    if @item.save
      redirect_to root_path   # 出品完了後はトップページへ
    else
      render :new, status: :unprocessable_entity  # エラー時は出品ページに戻る
    end
  end

  private

  # Strong Parameters（許可するカラムを明示）
  def item_params
    params.require(:item).permit(
      :name, :description, :category_id, :condition_id, :shipping_fee_id,
      :prefecture_id, :shipping_day_id, :price, :image
    )
  end
end

