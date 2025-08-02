## 1. **User_Creation.ps1**
```powershell
# User_Creation.ps1
# Purpose: Automate Single User Creation in Azure AD and Assign License
# Created by Jackson Paul J.

# Connect to Azure AD
Connect-AzureAD

# Prompt for User Details
$DisplayName = Read-Host "Enter Display Name"
$UserPrincipalName = Read-Host "Enter User Principal Name (e.g., user@domain.com)"
$UsageLocation = Read-Host "Enter Usage Location (e.g., IN, US)"
$LicenseSKU = Read-Host "Enter License SKU PartNumber (e.g., O365_BUSINESS)"

# Check if User Exists
$user = Get-AzureADUser -Filter "UserPrincipalName eq '$UserPrincipalName'"
if ($user) {
    Write-Host "User already exists: $UserPrincipalName" -ForegroundColor Yellow
    exit
}

# Generate Random Password
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = [System.Web.Security.Membership]::GeneratePassword(12,2)
$PasswordProfile.ForceChangePasswordNextLogin = $true

# Create User
New-AzureADUser -DisplayName $DisplayName -UserPrincipalName $UserPrincipalName -AccountEnabled $true -PasswordProfile $PasswordProfile -UsageLocation $UsageLocation -MailNickname ($UserPrincipalName.Split("@")[0])

# Assign License
$User = Get-AzureADUser -ObjectId $UserPrincipalName
$License = Get-AzureADSubscribedSku | Where-Object {$_.SkuPartNumber -eq $LicenseSKU}
Set-AzureADUserLicense -ObjectId $User.ObjectId -AssignedLicenses @{add=$License.SkuId}

Write-Host "User $UserPrincipalName created and license assigned." -ForegroundColor Green
```