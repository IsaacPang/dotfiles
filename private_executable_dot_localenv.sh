#!/usr/bin/env bash

# delcare an associative array for all environment variables
if [[ "$#" -eq 0 ]]; then
  source ~/.localenv
  export HTTP_PROXY HTTPS_PROXY DELOITTE_GEL_PAT INFRA_SPN_ID INFRA_SPN_SECRET
  echo "local environment set"
fi

while [[ "$#" -gt 0 ]]; do
  case $1 in
  -u | --unset)
    unset HTTP_PROXY HTTPS_PROXY
    echo "unset local env"
    shift
    ;;
  *)
    echo "unknown parameter passed: $1"
    shift
    ;;
  esac
done
