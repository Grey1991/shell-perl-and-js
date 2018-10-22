
function sum(list) {
  if (list.length == 0){return 0};
  return list.reduce((a,b)=> {return Number(a)+Number(b)});
}

module.exports = sum;
