# NTFS Permissions

## Purpose

Restrict folder access using Active Directory security groups.

## HR

| Principal | Permission |
|-----------|------------|
| SYSTEM | Full Control |
| Administrators | Full Control |
| IT_Admins | Full Control |
| HR_Users | Modify |

Repeat the same design for IT and Sales.

## Validation

- HR users can modify HR share.
- IT_Admins have full control.
- Other departments are denied.

## Suggested Screenshots

- ntfs-before.png
- ntfs-after.png
