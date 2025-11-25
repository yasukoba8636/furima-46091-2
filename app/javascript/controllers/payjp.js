document.addEventListener('DOMContentLoaded', function () {
  const form = document.getElementById('order-form');
  if (!form) return;

  // PAY.JP 公開鍵は環境変数で埋め込んでおく（meta タグなど）
  Payjp.setPublicKey(document.querySelector('meta[name="payjp-key"]').content);

  form.addEventListener('submit', function (e) {
    e.preventDefault();

    // カード情報を取得してトークンを生成するコード（payjp.js の API に合わせる）
    // 例（概念的）:
    const card = {
      number: document.querySelector('#card-number-input').value,
      cvc: document.querySelector('#card-cvc-input').value,
      exp_month: document.querySelector('#card-exp-month-input').value,
      exp_year: document.querySelector('#card-exp-year-input').value
    };

    Payjp.createToken(card, function (status, response) {
      if (response.error) {
        alert(response.error.message);
      } else {
        // token を form にセットして submit
        document.getElementById('payjp_token').value = response.id;
        form.submit();
      }
    });
  });
});
