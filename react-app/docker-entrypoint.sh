#!/bin/bash

set -e

if [ "$1" = 'start' ]; then
    yarn start
elif [ "$1" = 'test' ]; then
    CI=true yarn test
fi
