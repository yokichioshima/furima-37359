window.addEventListener('load', () => {
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  
  itemPrice.addEventListener('keyup', () => {
    const handingCharge = parseInt(itemPrice.value*0.1, 10)
    addTaxPrice.innerHTML = handingCharge;
    profit.innerHTML = itemPrice.value - handingCharge;
  });
});