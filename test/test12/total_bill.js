function total_bill(bill_list) {

  // PUT YOUR CODE HERE
  return bill_list.map(x=>x.map(e=>e.price.slice(1)).reduce((x,y)=>parseFloat(x)+parseFloat(y),0)).reduce((x,y)=>x+y,0);

}

module.exports = total_bill;
