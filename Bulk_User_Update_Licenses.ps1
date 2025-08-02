## 2. **Bulk_User_Update_Licenses.ps1**
```powershell
# Bulk_User_Update_Licenses.ps1
# Purpose: Bulk Update Licenses for Users from CSV
# Created by Jackson Paul J.

# Connect to Azure AD
Connect-AzureAD

# Import CSV
$Users = Import-Csv -Path ".\UsersToUpdate.csv"

# License SKU to Assign
$LicenseSKU = Read-Host "Enter License SKU PartNumber (e.g., O365_BUSINESS)"
$License = Get-AzureADSubscribedSku | Where-Object {$_.SkuPartNumber -eq $LicenseSKU}

foreach ($user in $Users) {
    $UPN = $user.UserPrincipalName
    $ADUser = Get-AzureADUser -ObjectId $UPN

    if ($ADUser) {
        $AssignedLicenses = (Get-AzureADUserLicenseDetail -ObjectId $ADUser.ObjectId).SkuPartNumber

        if ($AssignedLicenses -contains $LicenseSKU) {
            Write-Host "$UPN already has $LicenseSKU assigned." -ForegroundColor Yellow
        } else {
            Set-AzureADUserLicense -ObjectId $ADUser.ObjectId -AssignedLicenses @{add=$License.SkuId}
            Write-Host "$UPN assigned $LicenseSKU license." -ForegroundColor Green
        }
    } else {
        Write-Host "User not found: $UPN" -ForegroundColor Red
    }
}
```