# Example of changes to make to the generated configuration
# This demonstrates how to modify your imported infrastructure
#
# You would add these changes to your generated_config.tf file:

# resource "upcloud_server" "imported_vm" {
#   # The generated configuration will have many attributes here
#   # (including required fields like zone and network_interface blocks)
#   # We keep most of them the same but make these specific changes:
#   
#   # Change the hostname (visible in UI)
#   hostname = "terraform-managed-vm"
#   
#   # Add tags for better organization
#   tags = [
#     "managed-by-terraform",
#     "demo-environment"
#   ]
#   
#   # You can also modify other attributes like:
#   # - plan (to resize the VM)
#   # - firewall (to enable/disable the firewall)
#   # - metadata (to enable/disable metadata service)
# }
