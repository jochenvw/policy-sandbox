targetScope = 'subscription'

resource locationPolicyDefinition 'Microsoft.Authorization/policyDefinitions@2020-09-01' = {
  name: 'sql-enforce-add-auth'
  properties: {
    displayName: 'SQL Server: enforce AAD auth'
    policyType: 'Custom'
    mode: 'All'
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Sql/servers'
          }
          {
            field: 'Microsoft.Sql/servers/administrators.administratorType'
            notEquals: 'ActiveDirectory'
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

resource locationPolicy 'Microsoft.Authorization/policyAssignments@2020-09-01' = {
  name: 'SQL auth restriction'
  properties: {
    policyDefinitionId: locationPolicyDefinition.id
    displayName: 'Restrict access to SQL Servers'
  }
}
