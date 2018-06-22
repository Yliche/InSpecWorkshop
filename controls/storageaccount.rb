title 'Check Azure Resources'

control 'azure-generic-storage-account-2.0' do

  impact 1.0
  title 'Check the storage account for secure settings'

  # Get the storage account by type, this is because in the tests
  # the storage account name is randomly generated so it cannot be known to perform
  # these inspec tests
  describe azure_generic_resource(group_name: 'rg-vmscripts-cus-tst', type: 'Microsoft.Storage/storageAccounts') do

    # Check that the blob and file services are enabled
    its('properties.encryption.services.blob.enabled') { should be true }
    its('properties.encryption.services.file.enabled') { should be true }
    its('properties.encryption.keySource') { should cmp 'Microsoft.Storage' }

    its('properties.statusOfPrimary') { should cmp 'available' }

    # Determine if it only supports HTTPS traffic
    its('properties.supportsHttpsTrafficOnly') { should be true }
  end
end