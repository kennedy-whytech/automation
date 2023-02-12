# automation
## Initialize Terraform to download plug-ins as required 
```
terraform init
```
## Validate the configuration to ensure there are no errors or typos in the file 
```
terraform validate
```
## Perform a dry run 
```
terraform plan
```
## Deploy the infrastructure and monitor progress 
```
terraform apply
```
## Check the outputs defined in outputs.tf
```
terraform outputs
```
## Destroy all the resources
```
terraform destroy
```
## Verify deletion
```
terraform state list
terraform show
```

## Configure Azure blob container to store Terraform state information for security and team collaboration. First, define backend.tf. Then, follow the standard way to apply all .tf. 
```
az group create -l canadacentral -n tfstate<ID>RG
az storage account create -l canadacentral -n tfstate<ID>sa -g tfstate<ID>RG --sku Standard_LRS
az storage account keys list -g tfstate<ID>RG -n tfstate<ID>sa
az storage container create -n tfstatefiles --account-name tfstate<ID>sa --account-key “<access-key-from-previous-step>”
export ARM_ACCESS_KEY=<access-key-from-previous-step>
```

## Format
```
terraform fmt -recursive
```