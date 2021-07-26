var databaseName = 'sample-db-with-tde'
var databaseEdition = 'Basic'
var databaseCollation = 'SQL_Latin1_General_CP1_CI_AS'
var databaseServiceObjectiveName = 'Basic'

/**
* Taken from:
* https://docs.microsoft.com/en-us/azure/azure-sql/database/authentication-azure-ad-only-authentication-create-server?tabs=arm-template#azure-sql-database
*/
resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: 'jvw-sql-server'
  location: 'westeurope'
  properties: {
    administrators: {
      administratorType: 'ActiveDirectory'
      azureADOnlyAuthentication: true
      principalType: 'User'
      sid: 'f191905c-9c01-408c-b402-6940db1f363d'
      tenantId: '72f988bf-86f1-41af-91ab-2d7cd011db47'
      login: 'jowylick@microsoft.com'     
    }
  }
}

resource db 'Microsoft.Sql/servers/databases@2020-02-02-preview' = {
  parent: sqlServer
  name: databaseName
  location: 'westeurope'

  sku: {
    name: databaseServiceObjectiveName
    tier: databaseEdition
  }
  properties: {
    collation: databaseCollation
  }
}
