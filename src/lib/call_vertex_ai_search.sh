# shellcheck disable=SC2148
call_vertex_ai_search() {

    command_output=$(curl -s -X POST -H "Authorization: Bearer $token" -H "Content-Type: application/json" "https://discoveryengine.googleapis.com/v1alpha/projects/${GCP_PROJECT_NUMBER}/locations/global/collections/default_collection/dataStores/${DATASTORE_NAME}/servingConfigs/default_search:search" -d '{ "query": "'"${line}"'", "page_size": "1", "offset": 0 , "contentSearchSpec": { "snippetSpec":{"maxSnippetCount": 2}, "summarySpec":{"summaryResultCount": 3}} }') 
    error=$(echo "$command_output" | jq '.error.code' )
    if [ "$error" = '401' ]; then
        error_message=$(echo "$command_output" | jq '.error.message' )
        echo "Authentication failed. ErrorCode:$error ErrorMessage:$error_message"
        exit 1
    fi

}