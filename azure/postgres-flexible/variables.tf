variable "resource-group-properties" {
  description = "resource group properties"
  type        = map(any)
}

variable "postgres-flexible-properties" {
  description = "azure postgres flexible properties"
  type        = any
}

variable "vnet-id" {
  description = "virtual network id"
  type        = any
}

variable "vnet-name" {
  description = "virtual network name"
  type        = string
}
