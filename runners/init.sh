#!/bin/bash

TEMPLATE="template/template.html"

if [ $# -ne 1 ]; then
  echo "Usage: $0 PAGE"
  exit -1
fi

cp "${TEMPLATE}" "$1"
