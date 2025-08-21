locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-public-subnet-id = module.virtual-network.vnet-public-subnet-id

  # storage account properties
  storage-properties = {
    sa-name                          = "storage-account"
    sa-tier                          = "Standard"
    sa-kind                          = "StorageV2"
    sa-replication-type              = "LRS"
    sa-access-tier                   = "Hot"
    sa-https-traffic-only-enabled    = true
    sa-public-network-access-enabled = true

    sa_network_rules_enabled = true
    sa_network_rules_properties = {
      default_action = "Allow"
      bypass         = [] # Metrics, Logging, AzureServices (Default), None, set [] to remove it
    }

    sc-properties = {
      dev-tfstates = {
        sc-name                  = "dev-tfstates"
        sc-container-access-type = "private"
      }
      prod-tfstates = {
        sc-name                  = "prod-tfstates"
        sc-container-access-type = "private"
      }
    }

    sb-object-name        = "storage-blob-object"
    sb-object-type        = "Block"
    sb-object-source-path = "~/Desktop/"
  }
}
