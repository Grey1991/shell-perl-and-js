/*
  Given a list of games, which are objects that look like:

  {
    "id": 112814,
    "matches": "123",
    "tries": "11"
  }

  return a object like such

  {
    "totalMatches": m,
    "totalTries": y
  }

  Where m is the sum of all matches for all games
  and t is the sum of all tries for all games.

  input = [
    {"id": 1,"matches": "123","tries": "11"},
    {"id": 2,"matches": "1","tries": "1"},
    {"id": 3,"matches": "2","tries": "5"}
  ]

  output = {
    matches: 126,
    tries: 17
  }

  test with `node test.js stats.json`
  or `node test.js stats_2.json`
*/

function countStats(list) {
  // HINT: maybe REDUCE the problem ;)
  const sum = (x, y) => parseInt(x) + parseInt(y);
  return {
    matches: list.map((i)=>i.matches).reduce(sum,0),
    tries: list.map((i)=>i.tries).reduce(sum,0)
  };
}

module.exports = countStats;
