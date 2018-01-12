function ObjectToArray (dnaObject) {
  return [dnaObject.a, dnaObject.b, dnaObject.c, dnaObject.d, dnaObject.e, dnaObject.f]
}

/* always return a 'byte' */
function dec2bin (n) {
  return ('00000000' + n.toString(2)).substr(-8, 8)
}

function randomInt (max) {
  Math.floor(Math.random() * max)
}

function getCryptomonDNA (dna) {
  var _array

  if (dna instanceof Array) {
    _array = dna
  } else {
    _array = ObjectToArray(dna)
  }

  // _array = _array.reverse()

  let stringID = ''
  for (let i = 0; i < _array.length; i++) {
    stringID += dec2bin(_array[i])
  }

  let intID = parseInt(stringID, 2)
  return intID
}

// 5, 6, 11, 11, 11, 11
function generateRandomDna () {
  return getCryptomonDNA([
    randomInt(5),
    randomInt(6),
    randomInt(11),
    randomInt(11),
    randomInt(11),
    randomInt(11)
  ])
}

module.exports = {
  getCryptomonDNA,
  generateRandomDna,
};