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
# import {
#   to = upcloud_server.imported_vm
#   id = "00000000-0000-0000-0000-000000000000" # This will be replaced with actual VM ID
# }
