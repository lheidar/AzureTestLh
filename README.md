# Commands
terraform init  terraform plan -var resource_group_name=main-vnet -out vnet.tfplan  terraform apply "vnet.tfplan"
