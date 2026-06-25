# Drive Mapping

## Purpose
Automatically map department network drives.

| Drive | Share | Group |
|---|---|---|
| H: | \\DC01\HR | HR_Users |
| I: | \\DC01\IT | IT_Users |
| S: | \\DC01\Sales | Sales_Users |

## Configuration
- SMB shares created
- NTFS permissions configured
- Group Policy Preferences -> Drive Maps
- Item-level Targeting based on Security Groups

## Validation
- ola.hr receives H:
- cosmundsen receives I:
- kari.sales receives S:
- Users cannot access other department shares.

## Screenshots
- drive-mapping-gpo.png
- drive-targeting.png
- hr-drive.png
- it-drive.png
- sales-drive.png
- access-denied.png
