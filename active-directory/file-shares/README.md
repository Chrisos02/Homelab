# 📁 File Shares

This section documents the SMB file shares configured in the Active Directory homelab.

## Objectives

- Create department file shares
- Configure SMB sharing
- Configure NTFS permissions
- Control access using Active Directory security groups
- Validate user access

## Folder Structure

```
C:\Shares
├── HR
├── IT
└── Sales
```

## SMB Shares

| Share | UNC Path |
|-------|----------|
| HR | \\DC01\HR |
| IT | \\DC01\IT |
| Sales | \\DC01\Sales |

## Documentation

- shares-setup.md
- ntfs-permissions.md
- access-testing.md
