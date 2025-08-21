locals {
  # resource group properties
  resource-group-properties = {}

  # acr-login-server   = module.acr.acr-login-server
  # acr-admin-username = module.acr.acr-admin-username
  # acr-admin-password = module.acr.acr-admin-password

  # container app properties
  container-app-properties = {
    name                  = "container-apps"
    revision-mode         = "Single"
    workload-profile-name = "Consumption"
    identity-type         = "" # SystemAssigned, UserAssigned
    identity-ids          = []

    template-container-name = "nginx-container"
    # template-container-image  = "${local.acr-login-server}/nginx:latest"
    template-container-cpu    = 0.25
    template-container-memory = "0.5Gi"

    env = {
      "CONTAINER_NAME" = ""
    }

    template-min-replicas = 1
    template-max-replicas = 1

    ingress-allow-insecure-connections = false
    ingress-external-enabled           = true
    ingress-target-port                = 80
    ingress-transport                  = "auto"
  }
}
