#!/bin/bash -x

CODE_PATH="/app"
FAIL_OK_FILE=".tests_broken" 

function checkfail() {
  exit_code=$1
  [ $exit_code -ne 0 ] && {
    echo "Test failed with code $exit_code"	
    checkskip
  }
}

function checkskip() {
  if [ -f $FAIL_OK_FILE ]; then
    echo "$FAIL_OK_FILE found, ignoring test failures"
  else
    exit 1
  fi
}

[ ! -d ${CODE_PATH} ] && {
  echo "No codebase found at ${CODE_PATH}"
	exit 1
}

cd $CODE_PATH

nosetests -v  --cover-xml --with-xunit --with-coverage --cover-erase --cover-package=$CODE_PATH
checkfail $?

python -m coverage xml --include=$CODE_PATH/*

pylint -f parseable $CODE_PATH/* | tee /pylint.out
checkfail $?

sloccount --duplicates --wide --details user_service/ > /sloccount.sc

exit 0
