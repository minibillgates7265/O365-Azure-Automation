## 1. **User_Creation.ps1**
### Purpose:
Automates the creation of a single user in Azure Active Directory (AAD) with Office 365 license assignment.

### Flow:
- Connects to Azure AD Module.
- Prompts admin for user details (Name, UPN, UsageLocation).
- Creates a user with a secure random password.
- Assigns a predefined license SKU.

### Minimum Required Permissions:
- Azure AD User Administrator
- License Administrator

### Safety:
- Script is idempotent and checks if the user already exists before creating.

---

## 2. **Bulk_User_Update_Licenses.ps1**
### Purpose:
Bulk updates Office 365 license assignments for users from a CSV file.

### Flow:
- Imports a CSV file containing UPNs.
- Connects to Azure AD.
- Iterates through the list and assigns/removes specified licenses.

### Minimum Required Permissions:
- License Administrator

### Safety:
- Includes pre-checks for existing licenses to avoid redundant assignments.

---

## 3. **Add_Users_To_AzureGroup.ps1**
### Purpose:
Adds multiple users to a specified Azure AD Security Group.

### Flow:
- Connects to Azure AD.
- Reads UPNs from a CSV file.
- Adds users to a given Group Object ID.

### Minimum Required Permissions:
- Groups Administrator

### Safety:
- Skips adding if the user is already a member.

---

## ⚡ High Optimization Techniques Used
- AI-Assisted Script Structuring for Performance.
- Real-time Error Handling.
- Production Verified on Live Environments.
- Reusable Modular Functions.

---

## 🛡️ Usage Disclaimer
These scripts are production-ready but must be tested in a development environment before deployment. Ensure you follow your organization's compliance and security standards.

---

## 🤖 Created with AI Optimization
These scripts are crafted using AI assistance for high efficiency, and all automation flows are verified & used by **Jackson Paul J.** in real-time production environments.

---

## 🚀 Projected Purpose
This repository aims to showcase my expertise in Office 365, Azure, and Exchange automation using PowerShell and contributes to my professional portfolio for prospective employers.

---

## 📄 License
MIT License.