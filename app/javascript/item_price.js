function calcPrice() {
  const priceInput = document.getElementById("item-price");
  if (!priceInput) return; // ページに要素がなければ何もしない

  priceInput.addEventListener("input", () => {
    const price = parseInt(priceInput.value);
    const tax = Math.floor(price * 0.1);
    const profit = price - tax;

    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    if (isNaN(price) || price < 300 || price > 9999999) {
      addTaxDom.textContent = 0;
      profitDom.textContent = 0;
    } else {
      addTaxDom.textContent = tax;
      profitDom.textContent = profit;
    }
  });
}

window.addEventListener("turbo:load", calcPrice);
window.addEventListener("DOMContentLoaded", calcPrice);
