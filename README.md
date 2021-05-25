# Shared Resources

- [Intro](#intro)
- [Architecture](#architecture)
- [Domain Roadmap](#domain-roadmap)
- [Getting Started](#getting-started)
  - [Setting up the domain](#setting-up-the-domain)
- [Using the shared resources](#using-the-shared-resources)
  - [Shared SQL Server](#shared-sql-server)
- [Where can I get more help](#where-can-i-get-more-help)

## Intro

This domain will contain shared components of infrastructure, as well as code which we want to "centralize".
Initially we will work towards translating incoming ebiX messages in xml to an internal CIM format.

## Architecture

![design](ARCHITECTURE.png)

## Domain Roadmap

In this program increment we are working towards:

- Shared infrastructure will be identified and established.
- Publishing a NuGet package capable of converting Danish ebiX RSM-001, RSM-004 and RSM-033 documents to CIM compliant documents.
- Creation of best practices for working and interacting with domains.

## Setting up the domain

[Read here how to get started](https://github.com/Energinet-DataHub/green-energy-hub/blob/main/docs/getting-started.md).

## Using the shared resources

### Shared SQL Server

The Shared SQL Server is an empty server that other domains can add databases into.

To get started using the SQL Server, you will need to refer to the server as a Terraform Data Resource.

```ruby
data "azurerm_sql_server" "sqlsrv" {
  name                = "sqlsrv-sharedres-${var.organisation}-${var.environment}"
  resource_group_name = var.sharedresources_resource_group_name
}
```

Once this is done, you can now refer to the server from your local resources.

```ruby
resource "azurerm_mssql_database" "sqldb_yourname" {
  name                = "sqldb"
  server_id           = data.azurerm_sql_server.sqlsrv.id
}
```

### Shared SQL Server User

To use the shared admin user for the server, you can refer to the keyvault secrets, using the Terraform Data Resource

```ruby
data "azurerm_key_vault_secret" "SHARED_RESOURCES_DB_ADMIN_NAME" {
  name         = "SHARED-RESOURCES-DB-ADMIN-NAME"
  key_vault_id = data.azurerm_key_vault.kv_sharedresources.id
}

data "azurerm_key_vault_secret" "SHARED_RESOURCES_DB_ADMIN_PASSWORD" {
  name         = "SHARED-RESOURCES-DB-ADMIN-PASSWORD"
  key_vault_id = data.azurerm_key_vault.kv_sharedresources.id
}
```

## Where can I get more help?

Please see the [community documentation](https://github.com/Energinet-DataHub/green-energy-hub/blob/main/COMMUNITY.md)
