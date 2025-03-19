# This is an example of what the generated configuration might look like
# The actual output will depend on your specific UpCloud VM configuration

resource "upcloud_server" "imported_vm" {
  hostname = "my-imported-vm"
  zone     = "fi-hel1"
  plan     = "1xCPU-2GB"
  firewall = true
  metadata = true

  network_interface {
    type              = "public"
    ip_address_family = "IPv4"
  }

  network_interface {
    type              = "utility"
    ip_address_family = "IPv4"
  }

  storage_devices {
    address = "virtio:0"
    storage = "01000000-0000-4000-8000-000000000000" # This would be the actual storage UUID
    type    = "disk"
  }

  # Tags that may have been applied to the VM
  tags = [
    "imported",
    "demo"
  ]

  # System specifications
  cpu = 1
  mem = 2048
}
