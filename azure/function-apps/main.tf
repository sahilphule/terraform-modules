# resource "azurerm_monitor_action_group" "example" {
#   resource_group_name = var.resource-group-properties.name
#   name                = "example-actiongroup"

#   short_name          = "exampleAG"

#   email_receiver {
#     name          = "dev-team"
#     email_address = "dev-team@example.com"
#   }

#   arm_role_receiver {
#     name               = "resource-role-receiver"
#     role_id            = "/subscriptions/${var.subscription_id}/providers/Microsoft.Authorization/roleDefinitions/<role-guid>"
#     use_common_alert_schema = true
#   }
# }

# resource "azurerm_monitor_smart_detector_alert_rule" "failure-anomalies" {
#   resource_group_name = var.resource-group-properties.name
#   name                = "Failure Anomalies - ${azurerm_application_insights.app.name}"

#   scope_resource_ids  = [azurerm_application_insights.app.id]
#   detector_type       = "FailureAnomalies"
#   severity = "Sev3" # Sev0, Sev1, Sev2, Sev3, Sev4
#   frequency =

#   action_group {
#     ids = []
#   }
# }

resource "azurerm_application_insights" "function-app-application-insights" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location
  name                = var.function-app-properties.application-insights.name

  application_type = var.function-app-properties.application-insights.application-type
}

resource "azurerm_linux_function_app" "linux-function-app" {
  resource_group_name = var.resource-group-properties.name
  location            = var.resource-group-properties.location
  name                = var.function-app-properties.linux-function-app.name

  storage_account_name          = var.storage-account-name
  storage_account_access_key    = var.storage-account-access-key
  service_plan_id               = var.service-plan-id
  zip_deploy_file               = var.function-app-properties.linux-function-app.zip-deploy-file != "" ? var.function-app-properties.linux-function-app.zip-deploy-file : null
  public_network_access_enabled = var.function-app-properties.linux-function-app.public-network-access-enabled
  https_only                    = var.function-app-properties.linux-function-app.https-only
  # virtual_network_subnet_id = var.vnet-subnet-id

  identity {
    type = var.function-app-properties.linux-function-app.identity-type
  }

  site_config {
    application_insights_connection_string = azurerm_application_insights.function-app-application-insights.connection_string
    always_on                              = true

    application_stack {
      python_version = var.function-app-properties.linux-function-app.site-config-application-stack-python-version
    }

    cors {
      allowed_origins = ["https://portal.azure.com"]
    }
  }

  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = var.function-app-properties.linux-function-app.app-settings-website-run-from-package

    # Environment Variables
    # KEY_VAULT_URL = "https://my-keyvault.vault.azure.net/"
    # REDEPLOY_FUNCTION_URL = "https://myapp.azurewebsites.net/api/redeploy"
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      tags
    ]
  }
}

# resource "azurerm_key_vault_access_policy" "function-app-policy" {
#   key_vault_id = "/subscriptions/9defec2b-12e5-4f3a-8c9f-8edcac493dc8/resourceGroups/dev-resource-group/providers/Microsoft.KeyVault/vaults/dev-rean-key-vault"
#   tenant_id    = "04706dba-7535-45e9-8fb0-008d90d5b950"
#   object_id    = azurerm_linux_function_app.linux-function-app.identity[0].principal_id

#   secret_permissions = ["Get", "Set", "List"]
# }
