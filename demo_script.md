# UpCloud Terraform Import Demo Script

## Introduction

Hello everyone! Today, I'll demonstrate how to import existing infrastructure into Terraform using both the traditional import method and the newer generate-config feature. We'll be working with UpCloud as our cloud provider, but the concepts apply to any provider that supports Terraform imports.

## Environment Setup

### Prerequisites
- Terraform CLI installed (version 1.5.0 or higher)
- UpCloud account with API credentials
- An existing VM created in UpCloud's web console

### Project Structure
- `main.tf` - Contains provider configuration and import block

### Authentication Setup
"For this demo, we'll use environment variables for authentication:"

```
export UPCLOUD_USERNAME="your_api_username"
export UPCLOUD_PASSWORD="your_api_password"
```

"This is more secure than storing credentials in files and follows security best practices."

## Demo Steps

### 1. Show the Existing Infrastructure

*[Show the UpCloud console with the VM that was created manually]*

"This is a virtual machine I've already created through the UpCloud web interface. In a real-world scenario, this could represent legacy infrastructure that was set up before implementing Terraform."

*[Note the UUID of the server, which we'll need for the import]*

### 2. Prepare Terraform Configuration

"Now, let's look at our Terraform file to import this existing VM."

*[Show the main.tf file]*

```
terraform {
  required_providers {
    upcloud = {
      source  = "UpCloudLtd/upcloud"
      version = "5.20.4"
    }
  }
}

provider "upcloud" {
  # Credentials will be read from environment variables:
  # UPCLOUD_USERNAME and UPCLOUD_PASSWORD
}

# Import existing VM from UpCloud
import {
  to = upcloud_server.imported_vm
  id = "00000000-0000-0000-0000-000000000000" # Replace with actual VM UUID
}
```

"This single file contains both our provider configuration and the import block. The import block tells Terraform two important things:
1. What resource to create in our state (`upcloud_server.imported_vm`)
2. The ID of the existing infrastructure to import (our VM's UUID)"

### 3. Initialize Terraform

"First, we need to initialize our Terraform project:"

```
terraform init
```

*[Run the command and show the output]*

### 4. Traditional Import Approach (Without -generate-config-out)

"Let's first look at how imports worked traditionally without the generate-config feature."

"If we run a terraform plan now, Terraform will warn us that we need to create a resource block before applying the import:"

```
terraform plan
```

*[Show the output with warnings]*

"You'll notice that Terraform indicates our import block references a resource that doesn't exist in our configuration. Traditionally, we would need to manually create this resource block, which means:

1. Looking up the provider documentation
2. Understanding all required attributes
3. Manually inspecting the resource in the cloud provider console
4. Creating the resource block with all necessary attributes

Let me show what this would look like if I were to create this manually:"

*[Create a file called manual_config.tf]*

```
# This is what we would need to create manually without the generate-config feature
resource "upcloud_server" "imported_vm" {
  hostname = "my-imported-vm"
  zone     = "fi-hel1"
  plan     = "1xCPU-2GB"
  
  # We'd need to manually determine all required attributes
  # This is error-prone and time-consuming
  network_interface {
    type              = "public"
    ip_address_family = "IPv4"
  }
  
  storage_devices {
    address = "virtio:0"
    storage = "01000000-0000-0000-0000-000000000000"
    type    = "disk"
  }
}
```

"As you can see, this requires quite a bit of manual work and deep knowledge of the resource's schema."

### 5. Modern Import Approach (With -generate-config-out)

"Now, let's use the newer approach with the `-generate-config-out` flag, which automatically generates the configuration:"

```
terraform plan -generate-config-out=generated_config.tf
```

*[Run the command and show the output]*

"Terraform has analyzed our import block and generated a configuration file that describes the existing infrastructure. Let's look at the file it created:"

*[Show the generated_config.tf file]*

"This file contains all the attributes of our existing VM, formatted as proper Terraform configuration. This saves us from having to manually construct this configuration by inspecting the resource in the web console."

### 6. Compare the Approaches

"Let's compare these two approaches:

**Traditional Import (without -generate-config-out):**
- ✖️ Requires manually writing resource configuration before importing
- ✖️ Prone to errors and missing required attributes 
- ✖️ Requires deep knowledge of the provider's resource schema
- ✖️ Time-consuming, especially for complex resources

**Modern Import (with -generate-config-out):**
- ✓ Automatically generates resource configuration
- ✓ Reduces the chance of configuration errors
- ✓ Discovers all attributes of the existing resource
- ✓ Significantly faster, especially for complex resources
- ✓ Provides a good starting point that you can refine"

### 7. Apply the Import

"Now that we have both the import block and the generated configuration, let's run the apply command to actually import the resource into our Terraform state:"

```
terraform apply
```

*[Run the command and show the output]*

"Terraform has now imported our existing VM into its state. We can verify this by listing the state:"

```
terraform state list
```

### 8. Making Changes via Terraform

"Now that the VM is managed by Terraform, we can make changes using the Terraform workflow. For example, we could modify the configuration and apply changes."

"Let's edit the generated configuration file to make some visible changes to our VM. I'll add some tags and change the hostname to demonstrate that Terraform is now managing this resource:"

*[Open the generated_config.tf file and modify it]*

```
resource "upcloud_server" "imported_vm" {
  # Existing configuration...
  
  hostname = "terraform-managed-vm"  # Change the hostname from the original
  
  # Add tags to the server
  tags = [
    "managed-by-terraform",
    "demo-environment"
  ]
}
```

"Now let's apply these changes:"

```
terraform plan
```

*[Show the plan output which indicates the changes that will be made]*

"The plan shows that Terraform will update our VM with the new hostname and tags. Let's apply these changes:"

```
terraform apply
```

*[Show the apply output]*

"Great! Terraform has successfully modified our VM. Now let's verify these changes in the UpCloud console to confirm that our infrastructure has actually been updated."

*[Navigate to the UpCloud web console and show the VM details]*

"As you can see, the VM now has the new hostname 'terraform-managed-vm' and the tags we specified. This confirms that Terraform is now successfully managing our infrastructure."

"This is powerful because now we can:
1. Track all changes to our infrastructure in version control
2. Apply consistent changes across multiple environments
3. Use CI/CD pipelines to automate infrastructure changes
4. Collaborate on infrastructure changes with pull requests
5. Roll back changes if needed"

## Conclusion

"Today we've seen how Terraform's import capability with the generate-config feature makes it easier to bring existing infrastructure under Terraform management compared to the traditional import method. This is particularly useful when:

1. Migrating from manual management to infrastructure as code
2. Taking over management of resources created by another team
3. Recovering when infrastructure was created outside of Terraform

The key benefits of the generate-config approach are:
- Reduced manual work in creating the Terraform configuration
- Lower risk of errors in the import process
- Faster onboarding of existing resources

And once the infrastructure is imported, you can manage it completely through Terraform, as we demonstrated by making changes and seeing them reflected in the UpCloud console." 