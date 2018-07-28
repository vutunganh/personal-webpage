#!/bin/bash
# Sets up a page skeleton.

TEMPLATE="template/template.html"

if [ $# -ne 1 ]; then
  echo "Usage: $0 PAGE"
  echo "Run from repository root or else."
  exit -1
fi

cp "${TEMPLATE}" "$1"
