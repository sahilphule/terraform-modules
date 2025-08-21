locals {
  # resource group properties
  resource-group-properties = {}

  # vnet-infrastructure-subnet-id = module.virtual-network.vnet-infrastructure-subnet-id

  # container app setup properties
  container-app-setup-properties = {
    ca-log-analytics-workspace-name              = "container-apps-log-analytics-workspace"
    ca-log-analytics-workspace-sku               = "PerGB2018"
    ca-log-analytics-workspace-retention-in-days = 30

    ca-environment-name                               = "container-apps-environment"
    ca-environment-infrastructure-resource-group-name = "container-apps-environment-infrastructure-resource-group"
    ca-environment-workload-profile-name              = "Consumption" # Consumption type must have Consumption name
    ca-environment-workload-profile-type              = "Consumption" # Consumption, D4, D8, D16, D32, E4, E8, E16, E32
  }
}
