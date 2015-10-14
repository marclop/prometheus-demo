#!/bin/bash

DEPENDENCIES="awscli"
EXECS="pip"

if [[ "$1" == "build" ]];then
  APP_LANG="python"

  which ${APP_LANG} > /dev/null
  if [[ $? -ne 0 ]];then
    echo "--> ${APP_LANG} not installed!! Aborting"
    exit 1
  fi
  if [[ $? -eq 0 ]]; then
    echo "--> Already satisfied"
    exit 0
  fi
fi

## Pip
for EXEC in ${EXECS}; do
  which ${EXEC} > /dev/null
  if [[ $? -ne 0 ]];then
    i = $(( i + 1 ))
    echo "--> ${EXEC} not found, Installing it"
    sudo easy_install ${EXEC}
  fi
done

## Python deps
for DEP in ${DEPENDENCIES}; do
  if [[ "${DEP}" == "awscli" ]];then
    DEP="aws"
  fi
  which ${DEP} > /dev/null
  if [[ $? -ne 0 ]];then
    i=$(( $i + 1 ))
    echo "--> ${DEP} not found, Installing it"
    sudo pip install ${DEP}
  fi
done

eval "aws sts get-session-token --duration-seconds 900" > /dev/null

if [[ $? -ne 0 ]];then
  echo "--> Unable to connect to AWS, are you sure you have the appropriate credentials?"
fi

if [[ $? -eq 0 ]]; then
  if [[ ${i} -ge 1 ]] || [[ ${AWS_MISS} -ge 1 ]]; then
    echo "--> Done!"
  else
    echo "--> Already satisfied"
    exit 0
  fi
fi
