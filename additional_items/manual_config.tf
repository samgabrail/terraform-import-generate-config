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
