#!/bin/bash

ARTIFACT_DIR="artifacts"
COMPONENT="${1}"

## Remove zips if they exist
if [[ -d "${ARTIFACT_DIR}" ]]; then
  find artifacts/ -maxdepth 0 -empty -exec rm -f artifacts/* \;
else
  mkdir artifacts
fi

## Bundle the app
echo "--> Bundling ${COMPONENT}"
zip -q -9 -r artifacts/${COMPONENT}.zip . -x coverage\* artifacts\*

if [[ $? -eq 0 ]]; then
  echo "--> Done!"
fi
