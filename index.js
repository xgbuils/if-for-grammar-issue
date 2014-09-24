'use strict'

var parser = require('./test')

var result = parser.main([process.argv[0], 'a.js'])
console . log(result)