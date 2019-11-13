#!/bin/bash

source config.sh

#It creates a sample RG
az group create -n $resourceGroup -l $location > /dev/null

#GET A TOKEN
token=$(curl -s -X POST https://login.microsoftonline.com/$adTenantId/oauth2/token \
	-F "grant_type=client_credentials" \
	-F "resource=https://management.core.windows.net/" \
	-F "client_id=$clientId" \
	-F "client_secret=$clientSecret" | jq -r ".access_token" )

url="https://management.azure.com/subscriptions/$subscriptionId/resourcegroups/$resourceGroup?api-version=2019-05-10"

while true
do
#READ REQUEST
curl -si --request GET \
	--url $url \
	--header 'Accept: application/json' \
	--header "authorization: Bearer $token" | egrep "^date|x-ms-ratelimit-remaining-subscription" | awk '/remaining-subscription/ {remaining=$2; getline; date=$6; print date " READ: "remaining}' 

#WRITE REQUEST
curl -si --request PUT \
	--url $url \
	--header "Content-Type: application/json" \
	--header "Content-Length: 26" \
	-d '{"location": "$location"}' \
	--header "authorization: Bearer $token" | egrep "^date|x-ms-ratelimit-remaining-subscription" | awk '/remaining-subscription/ {remaining=$2; getline; date=$6; print date " WRITING: "remaining}' 
	
done	