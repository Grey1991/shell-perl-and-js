function species_count(target_species, whale_list) {

  // PUT YOUR CODE HERE
  return whale_list.filter(whale => whale.species === target_species).map(x=>x.how_many).reduce((a,b)=>a+b);

}

module.exports = species_count;
