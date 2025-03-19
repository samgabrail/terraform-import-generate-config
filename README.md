# UpCloud Terraform Import Demo

This repository demonstrates how to import existing UpCloud resources into Terraform using the generate config feature and compares it with the traditional import approach.

## Prerequisites

1. [Terraform](https://developer.hashicorp.com/terraform/downloads) installed (v1.5.0+)
2. UpCloud account with API credentials
3. An existing VM created in the UpCloud console

## Setup

1. Clone this repository
2. Set environment variables for UpCloud credentials:
   ```
   export UPCLOUD_USERNAME="your_api_username"
   export UPCLOUD_PASSWORD="your_api_password"
   ```
   For Windows PowerShell:
   ```
   $env:UPCLOUD_USERNAME="your_api_username"
   $env:UPCLOUD_PASSWORD="your_api_password"
   ```
3. Update the VM UUID in `main.tf` with your actual VM's UUID in the import block

## Demo Steps

### Traditional Import Approach (Without generate-config)

1. Initialize Terraform:
   ```
   terraform init
   ```

2. Run plan to see what needs to be created:
   ```
   terraform plan
   ```
   This will show warnings about missing resource definitions.

3. Manually create the resource configuration based on provider documentation and your existing infrastructure.

### Modern Import Approach (With generate-config)

1. Initialize Terraform (if not done already):
   ```
   terraform init
   ```

2. Generate configuration from existing resources:
   ```
   terraform plan -generate-config-out=generated_config.tf
   ```

3. Review the generated configuration in `generated_config.tf`

4. Apply the import:
   ```
   terraform apply
   ```

5. Verify the import was successful:
   ```
   terraform state list
   ```

### Making Changes with Terraform

1. Edit the generated configuration file to make changes. For example, add tags or change the hostname:
   ```
   resource "upcloud_server" "imported_vm" {
     # Existing configuration...
     
     hostname = "renamed-vm"  # Change the hostname
     
     tags = [
       "managed-by-terraform",
       "demo"
     ]
   }
   ```

2. Apply the changes:
   ```
   terraform apply
   ```

3. Verify the changes in the UpCloud Console:
   - Log into the UpCloud Console
   - Navigate to your Server list
   - Check that the VM has been updated with the new hostname and tags
   - This confirms that Terraform is now successfully managing your infrastructure

## Comparison of Approaches

| Traditional Import | Import with Generate-Config |
|-------------------|----------------------------|
| Requires manual resource configuration | Automatically generates configuration |
| Error-prone due to manual work | Reduces configuration errors |
| Requires deep knowledge of resource schema | Works with minimal provider knowledge |
| Time-consuming for complex resources | Significantly faster for all resources |
| No starting point for configuration | Provides complete starting configuration |

## Documentation References

- [Terraform Import with Generate Configuration](https://developer.hashicorp.com/terraform/language/import/generating-configuration)
- [UpCloud Terraform Provider](https://registry.terraform.io/providers/UpCloudLtd/upcloud/latest/docs)
- [UpCloud Server Resource](https://registry.terraform.io/providers/UpCloudLtd/upcloud/latest/docs/resources/server)
