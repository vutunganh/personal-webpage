#!/bin/bash
# Wraps up the pages and deploys them.

source runners/properties.sh

DRY_RUN=false
DONT_DELETE=false

while [ $# -gt 0 ]; do
  key="$1"
  case "${key}" in
    --help)
      echo "Usage: $0"
      echo "Arguments:"
      echo "  --dry-run        package the files but don't copy them to the server"
      echo "  --dont-delete    don't delete the deploy folder"
      exit 1
      ;;
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --dont-delete)
      DONT_DELETE=true
      shift
      ;;
  esac
done

mkdir deploy
cp *.html *.css *.js deploy

./runners/deploy.pl

if [ ${DRY_RUN} = false ]; then
  scp deploy/* "${USERNAME}"@"${SERVER_NAME}":"${TARGET_PATH}"
fi

if [ ${DONT_DELETE} = false ]; then
  rm -r deploy
fi
