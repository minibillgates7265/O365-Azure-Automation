## 3. **Add_Users_To_AzureGroup.ps1**
```powershell
# Add_Users_To_AzureGroup.ps1
# Purpose: Add Multiple Users to Azure AD Security Group
# Created by Jackson Paul J.

# Connect to Azure AD
Connect-AzureAD

# Import CSV with UserPrincipalName column
$Users = Import-Csv -Path ".\UsersToAdd.csv"

# Group Object ID
$GroupObjectId = Read-Host "Enter Group Object ID"

foreach ($user in $Users) {
    $UPN = $user.UserPrincipalName
    $ADUser = Get-AzureADUser -ObjectId $UPN

    if ($ADUser) {
        $isMember = Get-AzureADGroupMember -ObjectId $GroupObjectId | Where-Object {$_.ObjectId -eq $ADUser.ObjectId}

        if ($isMember) {
            Write-Host "$UPN is already a member of the group." -ForegroundColor Yellow
        } else {
            Add-AzureADGroupMember -ObjectId $GroupObjectId -RefObjectId $ADUser.ObjectId
            Write-Host "$UPN added to group." -ForegroundColor Green
        }
    } else {
        Write-Host "User not found: $UPN" -ForegroundColor Red
    }
}