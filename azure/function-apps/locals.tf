locals {
  # resource group properties
  resource-group-properties  = {}
  service-plan-id            = ""
  storage-account-name       = ""
  storage-account-access-key = ""
  vnet-subnet-id             = ""

  # linux function app properties
  function-app-properties = {
    application-insights = {
      name             = "application-insights"
      application-type = "other"
    }

    linux-function-app = {
      name                          = "linux-function-app"
      zip-deploy-file               = ""
      public-network-access-enabled = true
      https-only                    = true

      identity-type                                = "SystemAssigned"
      site-config-application-stack-python-version = "3.11"
      app-settings-website-run-from-package        = "1"
    }
  }
}
