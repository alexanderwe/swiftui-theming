#!/usr/bin/env bash
#MISE description="Format the project"

if [ -z "$1" ]; then
  TARGET_DIR="."
else
  TARGET_DIR="$1"
fi

swiftformat $TARGET_DIR --config .swiftformat