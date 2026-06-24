# Users, Groups and Organizational Units

## Overview

This section documents the Active Directory structure created in the lab.

The purpose is to simulate a small business environment with different departments, standard users, admin accounts, and role-based security groups.

---

## Organizational Units

The following OUs were created:

```text
homelab.local
│
├── OU_Users
├── OU_Computers
├── OU_Admins
├── OU_Servers
└── OU_Groups
```

---

## Why Use OUs?

Organizational Units are used to organize Active Directory objects and apply Group Policy.

Examples:

- `OU_Users` stores standard users
- `OU_Admins` stores administrative accounts
- `OU_Computers` stores domain-joined client computers
- `OU_Groups` stores security groups
- `OU_Servers` can store server objects later

---

## Users

### Standard Users

| Display Name | Username | OU |
|---|---|---|
| Chris Osmundsen | chris.it | OU_Users |
| Ola Hansen | ola.hr | OU_Users |
| Kari Nordmann | kari.sales | OU_Users |

### Admin Users

| Display Name | Username | OU |
|---|---|---|
| Chris Admin | cadmin | OU_Admins |

---

## Security Groups

The following security groups were created in `OU_Groups`:

| Group | Purpose |
|---|---|
| IT_Users | Standard IT users |
| HR_Users | HR users |
| Sales_Users | Sales users |
| IT_Admins | IT administrator accounts |
| Servers_Users | Server access testing |

---

## Group Memberships

| User | Group |
|---|---|
| chris.it | IT_Users |
| ola.hr | HR_Users |
| kari.sales | Sales_Users |
| cadmin | IT_Admins |

---

## Best Practice Used

Permissions should be assigned to groups, not directly to users.

Example:

```text
User → Group → Permission
```

Instead of:

```text
User → Permission
```

This makes administration easier and more realistic.

---

## PowerShell Commands

### List all OUs

```powershell
Get-ADOrganizationalUnit -Filter * | Select Name, DistinguishedName
```

### List all users

```powershell
Get-ADUser -Filter * | Select Name, SamAccountName
```

### List all groups

```powershell
Get-ADGroup -Filter * | Select Name
```

### Show users and group memberships

```powershell
Get-ADUser -Filter * -Properties MemberOf |
Select Name,SamAccountName,
@{Name="Groups";Expression={
($_.MemberOf | ForEach-Object {
(Get-ADGroup $_).Name
}) -join ", "
}} | Format-Table -AutoSize
```

---

## Key Concepts

- OUs are used for organization and Group Policy
- Groups are used for access control
- Users should be placed into groups based on role
- Admin accounts should be separate from normal user accounts
- Standard containers like `Users` and `Computers` are not the same as custom OUs

---

## Status

- [x] OU_Users created
- [x] OU_Computers created
- [x] OU_Admins created
- [x] OU_Servers created
- [x] OU_Groups created
- [x] Standard users created
- [x] Admin user created
- [x] Security groups created
- [ ] Group memberships verified

---

## Next Step

Proceed to:

```text
../04-client-join/04-client-domain-join.md
```
