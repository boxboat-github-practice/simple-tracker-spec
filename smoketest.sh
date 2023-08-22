#!/bin/bash

collection="api-test-collection.json"
environment="Local.postman_environment.json"
repo="https://api.github.com/repos/boxboat-github-practice/simple-tracker-spec/contents"

HALP() {
  printf '\nsmoketest.sh <test type>'
  printf '\nwhere <test type> is one of [employees, clients, contracts, history]\n'
  exit 1
}

if [ -z "$1" ]
then
  HALP
else
  newman run -k -n 1 -r cli --folder $1 -e \
    <(curl -s ${repo}/${environment} | jq  -r .content | base64 -d) \
    <(curl -s ${repo}/${collection} | jq  -r .content | base64 -d) 
fi

exit 0