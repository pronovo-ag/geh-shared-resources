# Copyright 2020 Energinet DataHub A/S
#
# Licensed under the Apache License, Version 2.0 (the "License2");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
data "azurerm_client_config" "current" {}

module "kv" {
  source                          = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault?ref=1.2.0"
  name                            = "kv${var.project}${var.organisation}${var.environment}"
  resource_group_name             = data.azurerm_resource_group.main.name
  location                        = data.azurerm_resource_group.main.location
  tags                            = data.azurerm_resource_group.main.tags
  enabled_for_template_deployment = true
  sku_name                        = "standard"

  access_policy = [
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = data.azurerm_client_config.current.object_id
      secret_permissions      = ["set", "get", "list", "delete"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = var.aggregations_domain_spn_object_id
      secret_permissions      = ["set", "get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = var.charges_domain_spn_object_id
      secret_permissions      = ["set", "get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = var.market_roles_domain_spn_object_id
      secret_permissions      = ["set", "get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = var.timeseries_domain_spn_object_id
      secret_permissions      = ["set", "get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = var.metering_point_domain_spn_object_id
      secret_permissions      = ["set", "get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = var.post_office_domain_spn_object_id
      secret_permissions      = ["set", "get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = var.validation_reports_domain_spn_object_id
      secret_permissions      = ["set", "get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    },
    {
      tenant_id               = data.azurerm_client_config.current.tenant_id
      object_id               = var.testing_domain_spn_object_id
      secret_permissions      = ["set", "get", "list"]
      certificate_permissions = []
      key_permissions         = []
      storage_permissions     = []
    }
  ]
}

module "kvs_db_admin_name" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.2.0"
  name          = "SHARED-RESOURCES-DB-ADMIN-NAME"
  value         = local.sqlServerAdminName
  key_vault_id  = module.kv.id
}

module "kvs_db_admin_password" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.2.0"
  name          = "SHARED-RESOURCES-DB-ADMIN-PASSWORD"
  value         = random_password.sqlsrv_admin_password.result
  key_vault_id  = module.kv.id
}

module "kvs_db_url" {
  source        = "git::https://github.com/Energinet-DataHub/geh-terraform-modules.git//key-vault-secret?ref=1.2.0"
  name          = "SHARED-RESOURCES-DB-URL"
  value         = module.sqlsrv.fully_qualified_domain_name
  key_vault_id  = module.kv.id
  dependencies  = [module.sqlsrv.dependent_on]
}