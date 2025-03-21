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

### Destroying Resources with Terraform

1. After successfully importing the VM, you can preview what would be destroyed:
   ```
   terraform plan -destroy
   ```
   This allows you to see which resources will be removed without actually removing them.

2. When ready, destroy the infrastructure:
   ```
   terraform destroy
   ```
   Terraform will ask for confirmation before proceeding.

3. Verify the destruction in the UpCloud Console:
   - Log into the UpCloud Console
   - Navigate to your Server list
   - Confirm that the VM has been completely removed
   - This demonstrates that Terraform is now fully managing the resource lifecycle

4. Benefits of using Terraform for destruction:
   - Ensures clean removal of all resources
   - Handles dependencies correctly (resources are destroyed in the right order)
   - Provides auditability through plan and state files
   - More reliable than manual deletion through the console

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
