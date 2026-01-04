#!/bin/bash

set -e

dart pub global activate clean_coverage 0.0.3

if which direnv > /dev/null; then
  direnv allow .
fi
