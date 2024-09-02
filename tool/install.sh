#!/bin/bash

set -e

echo 'Installing the global dart tools to run CI melos and the ci checks locally'

dart pub global activate clean_coverage 0.0.3

if which direnv > /dev/null; then
  direnv allow .
fi
