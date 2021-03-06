#!/bin/bash
# Wraps up the pages and deploys them.

source ./runners/properties.sh

DRY_RUN=false
DONT_DELETE=false
DEPLOY_FOLDER=deploy

while [ $# -gt 0 ]; do
  key="$1"
  case "${key}" in
    --help|-h)
      echo "Usage: $0."
      echo "Arguments:"
      echo "  -r|--dry-run        package the files but don't copy them to the server."
      echo "  -d|--dont-delete    don't delete the deploy folder."
      exit 1
      ;;
    --dry-run|-r)
      DRY_RUN=true
      shift
      ;;
    --dont-delete|-d)
      DONT_DELETE=true
      shift
      ;;
  esac
done

mkdir "${DEPLOY_FOLDER}"
cp -r pages/* *.css include/*.js "${DEPLOY_FOLDER}"

./runners/deploy.pl

if [ $? -ne 0 ]; then
  echo "Perl failed";
  exit 1;
fi

find "${DEPLOY_FOLDER}" -name '*.bak' -delete

if [ ${DRY_RUN} = false ]; then
  scp -r "${DEPLOY_FOLDER}"/* "${USERNAME}"@"${SERVER_NAME}":"${TARGET_PATH}"
  scp -r images "${USERNAME}"@"${SERVER_NAME}":"${TARGET_PATH}"
fi

if [ ${DONT_DELETE} = false ]; then
  rm -r "${DEPLOY_FOLDER}"
fi
