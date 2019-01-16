#!/bin/bash

set +e
set -o pipefail

URI=https://api.github.com
API_VERSION=v3
API_HEADER="Accept: application/vnd.github.${API_VERSION}+json; application/vnd.github.antiope-preview+json"
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}"

post_quality_control_message() {
   for i in ${!COMMIT_IDS[@]};
   do
      id=${COMMIT_IDS[$i]}
      content=$(<quality_message.txt)
      curl -vvvv -sSL -H "${AUTH_HEADER}" -H "${API_HEADER}" -d @quality_message.json -H "Content-Type: application/json" -X POST "${URI}/repos/${GITHUB_REPOSITORY}/commits/${id}/comments" 
   done

}

main() {
   commits=$(jq --raw-output .commits "$GITHUB_EVENT_PATH")

   COMMIT_IDS=()
   for row in $(echo "${commits}" | jq -r '.[] | @base64'); do
     message="$(echo "$row" | base64 --decode | jq -r '.message')"

     if [ ${#message} -ge 50 ]; then
        COMMIT_IDS+="$(echo "$row" | base64 --decode | jq -r '.id')"
        continue
     fi

   done

   post_quality_control_message;
}

main
