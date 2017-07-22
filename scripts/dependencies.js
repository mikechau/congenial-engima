'use strict'

var glob = require('glob');
var fs = require('fs');
var blasFiles = require('../src/blas-files');
var CLAPACK_BLAS_PATH = process.env.CLASPACK_BLAS_PATH || './clapack/BLAS/SRC';

var funcIdentifierToName = {};
var funcIdentifiers = [];

blasFiles.forEach(function(f) {
  funcIdentifiers.push(f + '_');
  funcIdentifierToName[f + '_'] = f;
});

var dependencies = {};

glob(CLAPACK_BLAS_PATH + '/*.c', function(err, files) {
  files.forEach(function (file) {
    var content = fs.readFileSync(file, "utf8");

    var func = file.match(/.*\/([^.]*)\.c$/)[1];
    for (var i = funcIdentifiers.length; i >= 0; i--) {
      var identifier = funcIdentifiers[i]
      if (content.indexOf(identifier) !== -1) {
        var dep = funcIdentifierToName[identifier]

        if (dep !== func) {
          dependencies[func] = dependencies[func] || [];
          dependencies[func].push(dep);
        }

      }
    }
  });

  console.log(dependencies)
});

