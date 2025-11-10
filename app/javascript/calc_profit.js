function calcProfit() {
  const priceInput = document.getElementById("item-price");
  console.log("イベント発火");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  // 出品ページ以外では動作させない
  if (!priceInput || !addTaxDom || !profitDom) return;

  priceInput.addEventListener("input", () => {
    const inputValue = parseInt(priceInput.value, 10);

    // 入力値が数字でない場合（空欄など）は0にしておく
    if (isNaN(inputValue)) {
      addTaxDom.textContent = "0";
      profitDom.textContent = "0";
      return;
    }

    // 手数料10%・利益計算
    const addTax = Math.floor(inputValue * 0.1);
    const profit = Math.floor(inputValue - addTax);

    // HTMLに表示（3桁区切り）
    addTaxDom.textContent = addTax.toLocaleString();
    profitDom.textContent = profit.toLocaleString();
  });
}

// Turboでページ遷移時にもイベントを再登録
document.addEventListener("turbo:load", calcProfit);
document.addEventListener("turbo:render", calcProfit);

window.addEventListener('turbo:load', () => {
  console.log("OK");
});