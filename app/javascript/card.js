document.addEventListener("turbo:load", () => {
  if (!document.getElementById("charge-form")) return;

  const publicKey = process.env.PAYJP_PUBLIC_KEY;
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();

  const cardNumber = elements.create("cardNumber");
  cardNumber.mount("#card-number");

  const cardExpiry = elements.create("cardExpiry");
  cardExpiry.mount("#card-exp-month");

  const cardCvc = elements.create("cardCvc");
  cardCvc.mount("#card-cvc");

  const form = document.getElementById("charge-form");

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(cardNumber).then((response) => {
      if (response.error) return form.submit();

      const token = response.id;
      document.getElementById("card-token").value = token;

      form.submit();
    });
  });
});
