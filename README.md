## Azure ARM API Throttling check

This tool allows you to check the number of API calls you can do before throttled

You need to create a file named config.sh with the following sample content:
```
#PRINCIPAL DATA

##Name of the principal
clientName="test-api-capacity"
##Secret of the principal
clientSecret="xcxcxcxcxcxcxcxcxcD.Di-8"
##ID of the principal
clientId="6d97fdf1-1111-2222-3333-2517396dfc12"

#ENVIRONMENT DATA
#Your tenant ID
adTenantId="1111111-22222-41af-91ab-2d7cd011db47"
#Your subscription ID
subscriptionId="1111111-d373-4afb-a5d6-7c44f098d16a"
#Sample resource group to be created. API needs to write
resourceGroup="testPrincipal"
#Region
location="westeurope"
```
## Run the script:

```
$ ./monitor-throttling.sh
17:29:38 READ: 11974
17:29:39 READ: 11987
17:29:40 READ: 11972
17:29:40 READ: 11997

```
