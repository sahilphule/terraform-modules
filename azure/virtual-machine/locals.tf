locals {
  # resource group properties
  resource-group-properties = {}

  # virtual-machine-properties
  virtual-machine-properties = {
    public-ip-name              = "linux-vm-public-ip"
    public-ip-allocation-method = "Static"

    network-interface = {
      name                          = "nic"
      ip-configuration-name         = "test-configuration"
      private-ip-address-allocation = "Dynamic"
    }

    network-security = {
      group-name = "vm-network-security-group"

      rule-count                      = 3
      rule-name                       = ["ssh-inbound", "http-inbound", "http-outbound"]
      rule-priority                   = [100, 200, 300]
      rule-direction                  = ["Inbound", "Inbound", "Outbound"]
      rule-access                     = ["Allow", "Allow", "Allow"]
      rule-protocol                   = ["Tcp", "Tcp", "Tcp"]
      rule-source-port-range          = ["22", "80", "80"]
      rule-destination-port-range     = ["22", "80", "80"]
      rule-source-address-prefix      = ["*", "*", "*"]
      rule-destination-address-prefix = ["*", "*", "*"]
    }

    linux-vm = {
      name                            = "linux-vm"
      size                            = "Standard_DS1_v2"
      admin-username                  = "root"
      admin-password                  = "password"
      disable-password-authentication = false

      admin-ssh-key-username = "linux-vm-ssh-key"

      os-disk-name                 = "linux-vm-os-disk"
      os-disk-caching              = "ReadWrite"
      os-disk-storage-account-type = "Standard_LRS"

      source-image-reference-publisher = "Canonical"
      source-image-reference-offer     = "UbuntuServer"
      source-image-reference-sku       = "22_04-lts"
      source-image-reference-version   = "latest"
    }
  }
}
