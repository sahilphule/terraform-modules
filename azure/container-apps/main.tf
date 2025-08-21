resource "azurerm_container_app" "container-app" {
  resource_group_name = var.resource-group-properties.name

  name                         = var.container-app-properties.name
  container_app_environment_id = var.container-app-environment-id
  revision_mode                = var.container-app-properties.revision-mode
  workload_profile_name        = var.container-app-properties.workload-profile-name

  dynamic "identity" {
    for_each = var.container-app-properties.identity-type == "" ? [] : [1]
    content {
      type         = var.container-app-properties.identity-type
      identity_ids = length(var.container-app-properties.identity-ids) == 0 ? null : var.container-app-properties.identity-ids
    }
  }

  registry {
    server               = var.acr-login-server
    username             = var.acr-admin-username
    password_secret_name = "acr-admin-password"
  }

  secret {
    name  = "acr-admin-password"
    value = var.acr-admin-password
  }

  template {
    container {
      name   = var.container-app-properties.template-container-name
      image  = var.container-app-properties.template-container-image
      cpu    = var.container-app-properties.template-container-cpu
      memory = var.container-app-properties.template-container-memory

      dynamic "env" {
        for_each = var.container-app-properties.env
        content {
          name  = env.key
          value = env.value
        }
      }

    }
    min_replicas = var.container-app-properties.template-min-replicas
    max_replicas = var.container-app-properties.template-max-replicas
  }

  ingress {
    allow_insecure_connections = var.container-app-properties.ingress-allow-insecure-connections
    external_enabled           = var.container-app-properties.ingress-external-enabled
    # exposed_port               = 80
    target_port = var.container-app-properties.ingress-target-port
    transport   = var.container-app-properties.ingress-transport

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }
}
