#!/bin/bash

set -euxo pipefail

if [[ -d custom ]]; then
  echo "Building custom bundle..."

  if [[ -f custom/export-functions.js ]]; then
    echo "Adding custom export-functions.js..."

    mv src/export-functions.js src/export-functions.js.bak

    cp custom/export-functions.js src/export-functions.js
  fi

  if [[ -f custom/lapack-files.js ]]; then
    echo "Adding custom lapack-files.js..."

    mv src/lapack-files.js src/lapack-files.js.bak

    cp custom/lapack-files.js src/lapack-files.js
  fi

  if [[ -f custom/blas-files.js ]]; then
    echo "Adding custom bla-files.js..."

    mv src/blas-files.js src/blas-files.js.bak

    cp custom/blas-files.js src/blas-files.js
  fi

  npm run build

  echo "Cleaning up custom build..."

  if [[ -f custom/export-functions.js ]]; then
    echo "Removing custom export-functions.js..."

   rm  src/export-functions.js

    mv src/export-functions.js.bak src/export-functions.js
  fi

  if [[ -f custom/lapack-files.js ]]; then
    echo "Removing custom lapack-files.js..."

    rm src/lapack-files.js

    mv src/lapack-files.js.bak src/lapack-files.js
  fi

  if [[ -f custom/blas-files.js ]]; then
    echo "Removing custom blas-files.js..."

    rm src/blas-files.js
    
    mv src/blas-files.js.bak src/blas-files.js
  fi
else
  echo "Building default bundle (all functions)..."

  npm run build
fi
