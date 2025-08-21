locals {
  # key-vault properties
  key-vault-properties = {
    key-vault = {
      name                          = "key-vault"
      sku-name                      = "standard"
      soft-delete-retention-days    = 7
      purge-protection-enabled      = true
      public-network-access-enabled = true
    }

    # access-policy = {
    #   key-permissions    = ["Get", "List", "Set"]
    #   secret-permissions = ["Get", "List", "Set"]
    # }
  }
}
