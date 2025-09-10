locals {
  # resource group properties
  resource-group-properties = {}

  # service plan properties
  # Consumption:- Y1
  # Flex Consumption:- FC1
  # Functions Premium:- EP1, EP2, EP3
  # App Service Plan:- B1, B2, B3, S1, S2, S3, P1v3, P2v3, P1v3
  service-plan-properties = {
    name     = "service-plan"
    os-type  = "Linux"
    sku-name = "B1"
  }
}
